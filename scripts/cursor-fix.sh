#!/usr/bin/env bash
# Link missing cursor aliases (CSS/freedesktop <-> legacy X11) in an Xcursor theme.
#
# Usage: cursor-fix.sh [-n dry-run] [-v verbose] [THEME_DIR|CURSORS_DIR]...

set -euo pipefail

dry_run=0
verbose=0

while getopts "nvh" opt; do
  case "$opt" in
    n) dry_run=1 ;;
    v) verbose=1 ;;
    *)
      sed -n '2,4p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
  esac
done
shift $((OPTIND - 1))

# One shape per line; missing names link to the first that exists.
ALIAS_GROUPS='
default left_ptr arrow top_left_arrow
pointer hand2 hand pointing_hand 9d800788f1b08800ae810202380a0822 e29285e634086352946a0e7090d73106
text xterm ibeam
wait watch
progress left_ptr_watch half-busy 08e8e1c95fe2fc01f976f1e063a24ccd 3ecb610c1bf2410f44200f48c40d3599
help question_arrow left_ptr_help whats_this 5c6cd98b3f3ebcb1f9c7f1c204630408 d9ce0ab605698f320427677b458ad60b
crosshair cross cross_reverse diamond_cross tcross
not-allowed crossed_circle forbidden circle 03b6e0fcb3499374a867c041f52298f0
grab openhand hand1 5aca4d189052212118709018842178c0
grabbing closedhand dnd-none 208530c400c041818281048008011002
move all-scroll all-resize fleur size_all fcf21c00b30f7e3f83fe0dfd12e71cff 4498f0e0c1937ffe01fd06f973665830 9081237383d90e509aa00f00170e968f
ns-resize sb_v_double_arrow v_double_arrow double_arrow size_ver 00008160000006810000408080010102 2870a09082c103050810ffdffffe0204
ew-resize sb_h_double_arrow h_double_arrow size_hor 028006030e0e7ebffc7f7070c0600140 14fef782d02440884392942c11205230
nwse-resize bd_double_arrow size_fdiag c7088f0f3e6c8088236ef8e1e3e70000
nesw-resize fd_double_arrow size_bdiag fcf1c3c7cd4491d801f1e1c78f10
n-resize top_side
s-resize bottom_side
e-resize right_side
w-resize left_side
ne-resize top_right_corner
nw-resize top_left_corner
se-resize bottom_right_corner
sw-resize bottom_left_corner
copy dnd-copy 1081e37283d90000800003c07f3ef6bf 6407b0e94181790501fd1e167b474872
alias link dnd-link 3085a0e285430894940527032f8b26df 640fb0e74195791501fd1ed57b41487f a2a266d0498c3104214a47bd64ab0fc8
context-menu
cell plus
vertical-text
zoom-in
zoom-out
X_cursor pirate
right_ptr draft_large draft_small
center_ptr
pencil
dotbox dot_box_mask draped_box icon target
sb_up_arrow up_arrow
sb_down_arrow down_arrow
sb_left_arrow left_arrow
sb_right_arrow right_arrow
'

# "NAME FALLBACK..." links only NAME, when no dedicated shape exists.
FALLBACK_GROUPS='
progress wait
wait progress
row-resize ns-resize
col-resize ew-resize
split_v ns-resize
split_h ew-resize
no-drop dnd-no-drop not-allowed
dnd-move move default
dnd-ask context-menu help
grab grabbing pointer
grabbing grab
hand1 grab pointer
all-scroll move
copy default
dnd-copy copy
right_ptr default
X_cursor not-allowed
vertical-text text
'

log() { printf '%s\n' "$*"; }
note() { [ "$verbose" -eq 1 ] && log "$@" || true; }

declare -A created

exists() { [ -e "$dir/$1" ] || [ -L "$dir/$1" ] || [ -n "${created[$1]:-}" ]; }

real_target() {
  local name="$1" path="$dir/$1"
  if [ -n "${created[$name]:-}" ]; then
    printf '%s' "${created[$name]}"
    return 0
  fi
  [ -e "$path" ] || return 0
  if [ -L "$path" ]; then
    local resolved
    resolved=$(readlink -f -- "$path") || return 0
    [ -f "$resolved" ] || return 0
    case "$resolved" in
      "$dir"/*) basename -- "$resolved" ;;
      *) return 0 ;;
    esac
  else
    [ -f "$path" ] && printf '%s' "$name"
  fi
}

make_link() {
  local target="$1" name="$2"
  created[$name]=$target
  if [ "$dry_run" -eq 1 ]; then
    log "  would link  $name -> $target"
  else
    ln -s -- "$target" "$dir/$name"
    log "  link  $name -> $target"
  fi
}

prune_dangling() {
  local d="$1" link label
  while IFS= read -r -d '' link; do
    label="$(basename -- "$d")/$(basename -- "$link") -> $(readlink -- "$link")"
    if [ "$dry_run" -eq 1 ]; then
      log "  would remove dangling  $label"
    else
      rm -- "$link"
      log "  remove dangling  $label"
    fi
  done < <(find "$d" -maxdepth 1 -xtype l -print0)
}

apply_groups() {
  local groups="$1" only_first="${2:-}" line target name
  while IFS= read -r line; do
    [ -n "$line" ] || continue
    # shellcheck disable=SC2086
    set -- $line

    target=""
    for name in "$@"; do
      target=$(real_target "$name")
      [ -n "$target" ] && break
    done

    if [ -z "$target" ]; then
      [ -z "$only_first" ] && missing+=("$1")
      continue
    fi

    if [ -n "$only_first" ]; then
      set -- "$1"
    fi

    for name in "$@"; do
      if exists "$name"; then
        note "  ok    $name"
        continue
      fi
      make_link "$target" "$name"
    done
  done <<<"$groups"
}

fix_theme() {
  local root="$1"
  root=${root%/}

  if [ -d "$root/cursors" ]; then
    dir="$root/cursors"
  elif [ "$(basename -- "$root")" = "cursors" ] && [ -d "$root" ]; then
    dir="$root"
    root=$(dirname -- "$root")
  else
    log "skip: $root is not a cursor theme (no cursors/ directory)"
    return 1
  fi

  if [ "$dry_run" -eq 0 ] && [ ! -w "$dir" ]; then
    log "error: $dir is not writable (try sudo)"
    return 1
  fi

  log "==> $dir"
  missing=()
  created=()

  prune_dangling "$dir"
  [ "$root" != "$dir" ] && prune_dangling "$root"

  apply_groups "$ALIAS_GROUPS"
  apply_groups "$FALLBACK_GROUPS" only_first
  apply_groups "$ALIAS_GROUPS"

  local still=() m
  for m in "${missing[@]:-}"; do
    [ -n "$m" ] && ! exists "$m" && still+=("$m")
  done
  if [ "${#still[@]}" -gt 0 ]; then
    log "  shapes the theme does not provide (no file to link to):"
    printf '    %s\n' "${still[@]}" | sort -u
  fi
}

if [ "$#" -eq 0 ]; then
  set -- "$PWD"
fi

status=0
for theme in "$@"; do
  fix_theme "$theme" || status=1
done
exit "$status"

#!/usr/bin/env bash
# Link missing cursor aliases (CSS/Wayland <-> legacy X11) in Xcursor + scalable themes.
#
# Covers GNOME 51 / Adwaita 51 canonical set (cursor-shape-v1 v2: 36 names
# including dnd-ask, all-resize) plus legacy X11 hashes, sb_*, fleur, etc.
# Fixes both cursors/ (files) and cursors_scalable/ (dirs with metadata.json).
#
# Usage: cursor-fix.sh [-n dry-run] [-v verbose] [-p no-prune] [THEME_DIR|CURSORS_DIR]...

set -euo pipefail

dry_run=0
verbose=0
prune=1

usage() { sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; }

while getopts "nvph" opt; do
  case "$opt" in
    n) dry_run=1 ;;
    v) verbose=1 ;;
    p) prune=0 ;;
    *) usage; exit 0 ;;
  esac
done
shift $((OPTIND - 1))

# Equivalence sets. First existing entry wins, rest link to it.
# Modern CSS/Wayland name first, legacy/X11 hash last.
ALIAS_GROUPS='
default left_ptr arrow top_left_arrow
pointer hand2 hand pointing_hand 9d800788f1b08800ae810202380a0822 e29285e634086352946a0e7090d73106
text xterm ibeam
wait watch
progress left_ptr_watch half-busy 08e8e1c95fe2fc01f976f1e063a24ccd 3ecb610c1bf2410f44200f48c40d3599 00000000000000020006000e7e9ffc3f
help question_arrow left_ptr_help whats_this 5c6cd98b3f3ebcb1f9c7f1c204630408 d9ce0ab605698f320427677b458ad60b
crosshair cross cross_reverse diamond_cross tcross
not-allowed crossed_circle circle forbidden 03b6e0fcb3499374a867c041f52298f0
grab openhand hand1 5aca4d189052212118709018842178c0
grabbing closedhand dnd-none 208530c400c041818281048008011002
move dnd-move fcf21c00b30f7e3f83fe0dfd12e71cff 4498f0e0c1937ffe01fd06f973665830 9081237383d90e509aa00f00170e968f
all-resize all-scroll fleur size_all
ns-resize sb_v_double_arrow v_double_arrow double_arrow size_ver size-ver 00008160000006810000408080010102 2870a09082c103050810ffdffffe0204
ew-resize sb_h_double_arrow h_double_arrow size_hor size-hor 028006030e0e7ebffc7f7070c0600140 14fef782d02440884392942c11205230
nwse-resize bd_double_arrow size_fdiag size-fdiag c7088f0f3e6c8088236ef8e1e3e70000
nesw-resize fd_double_arrow size_bdiag size-bdiag fcf1c3c7cd4491d801f1e1c78f10
n-resize top_side
s-resize bottom_side
e-resize right_side
w-resize left_side
ne-resize top_right_corner
nw-resize top_left_corner
se-resize bottom_right_corner
sw-resize bottom_left_corner
copy dnd-copy 1081e37283d90000800003c07f3ef6bf 6407b0e94181790501fd1e167b474872 b66166c04f8c3109214a4fbd64a50fc8
alias link dnd-link 3085a0e285430894940527032f8b26df 640fb0e74195791501fd1ed57b41487f a2a266d0498c3104214a47bd64ab0fc8
context-menu dnd-ask
cell plus
vertical-text
zoom-in
zoom-out
X_cursor pirate
right_ptr draft_large draft_small
center_ptr
pencil
dotbox dot_box_mask draped_box icon target
sb_up_arrow up_arrow up-arrow
sb_down_arrow down_arrow down-arrow
sb_left_arrow left_arrow left-arrow
sb_right_arrow right_arrow right-arrow
col-resize split_h
row-resize split_v
'

# Directional fallback: link only $1 when missing.
FALLBACK_GROUPS='
progress wait
wait progress
row-resize ns-resize
col-resize ew-resize
split_v ns-resize row-resize
split_h ew-resize col-resize
no-drop dnd-no-drop not-allowed
move default all-scroll
dnd-move move default all-scroll
dnd-ask context-menu dnd-copy help
all-resize fleur move all-scroll
all-scroll move all-resize fleur
grab grabbing pointer
grabbing grab
hand1 grab pointer
all-scroll move
copy default
dnd-copy copy
right_ptr default
X_cursor not-allowed
vertical-text text
size-ver ns-resize n-resize s-resize
size-hor ew-resize e-resize w-resize
size-fdiag nwse-resize
size-bdiag nesw-resize
up-arrow n-resize
down-arrow s-resize
left-arrow w-resize
right-arrow e-resize
'

log() { printf '%s\n' "$*"; }
note() { [ "$verbose" -eq 1 ] && log "$@" || true; }

if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
  C_HDR=$'\e[1;36m' C_OK=$'\e[32m' C_LINK=$'\e[1;32m' C_RM=$'\e[1;33m'
  C_DIM=$'\e[2m' C_WARN=$'\e[1;33m' C_ERR=$'\e[1;31m' C_RESET=$'\e[0m'
else
  C_HDR='' C_OK='' C_LINK='' C_RM='' C_DIM='' C_WARN='' C_ERR='' C_RESET=''
fi

n_link=0; n_rm=0; n_ok=0; n_theme=0
tag() { [ "$dry_run" -eq 1 ] && printf '%s[dry-run]%s ' "$C_DIM" "$C_RESET" || true; }
hdr() { n_theme=$((n_theme+1)); log "${C_HDR}❯ $1${C_RESET}"; }
warn_msg() { log "  ${C_WARN}!${C_RESET} $*"; }
err_msg() { log "  ${C_ERR}x${C_RESET} $*"; }

declare -A created
missing=()

dir_exists() { [ -e "$1/$2" ] || [ -L "$1/$2" ] || [ -n "${created[$1::$2]:-}" ]; }

real_target() {
  local d="$1" name="$2" resolved
  local path="$d/$2"
  if [ -n "${created[$d::$name]:-}" ]; then
    printf '%s' "${created[$d::$name]}"
    return 0
  fi
  [ -e "$path" ] || return 0
  if [ -L "$path" ]; then
    resolved=$(readlink -f -- "$path") || return 0
    [ -e "$resolved" ] || return 0
    case "$resolved" in
      "$d"/*) basename -- "$resolved" ;;
      *) return 0 ;;
    esac
  else
    printf '%s' "$name"
  fi
}

make_link() {
  local d="$1" target="$2" name="$3"
  created[$d::$name]=$target
  [ "$dry_run" -eq 0 ] && ln -sfn -- "$target" "$d/$name"
  n_link=$((n_link+1))
  log "  $(tag)${C_LINK}→${C_RESET} $(basename -- "$d")/$name ${C_DIM}->${C_RESET} $target"
}

prune_dangling() {
  local d="$1" link
  while IFS= read -r -d '' link; do
    [ "$dry_run" -eq 0 ] && rm -- "$link"
    n_rm=$((n_rm+1))
    log "  $(tag)${C_RM}✕${C_RESET} $(basename -- "$d")/$(basename -- "$link")"
  done < <(find "$d" -maxdepth 1 -xtype l -print0)
}

apply_groups() {
  local d="$1" groups="$2" only_first="${3:-}" line target name
  while IFS= read -r line; do
    [ -n "$line" ] || continue
    # shellcheck disable=SC2086
    set -- $line
    target=""
    for name in "$@"; do
      target=$(real_target "$d" "$name")
      [ -n "$target" ] && break
    done
    if [ -z "$target" ]; then
      [ -z "$only_first" ] && missing+=("$d::$1")
      continue
    fi
    if [ -n "$only_first" ]; then
      set -- "$1"
    fi
    for name in "$@"; do
      if dir_exists "$d" "$name"; then
        n_ok=$((n_ok+1))
        note "  ${C_OK}✓${C_RESET} ${C_DIM}$(basename -- "$d")/$name${C_RESET}"
        continue
      fi
      make_link "$d" "$target" "$name"
    done
  done <<<"$groups"
}

fix_dir() {
  local d="$1"
  [ -d "$d" ] || return 0
  if [ "$dry_run" -eq 0 ] && [ ! -w "$d" ]; then
    err_msg "$d is not writable (try sudo)"
    return 1
  fi
  hdr "$d"
  [ "$prune" -eq 1 ] && prune_dangling "$d"
  apply_groups "$d" "$ALIAS_GROUPS"
  apply_groups "$d" "$FALLBACK_GROUPS" only_first
  apply_groups "$d" "$ALIAS_GROUPS"
}

fix_theme() {
  local root="$1"
  root=${root%/}
  local dirs=()
  case "$(basename -- "$root")" in
    cursors|cursors_scalable)
      if [ ! -d "$root" ]; then
        warn_msg "skip: $root is not a directory"
        return 1
      fi
      dirs+=("$root")
      root=$(dirname -- "$root")
      ;;
    *)
      if [ ! -d "$root/cursors" ] && [ ! -d "$root/cursors_scalable" ]; then
        warn_msg "skip: $root is not a cursor theme (no cursors/ or cursors_scalable/)"
        return 1
      fi
      [ -d "$root/cursors" ] && dirs+=("$root/cursors")
      [ -d "$root/cursors_scalable" ] && dirs+=("$root/cursors_scalable")
      ;;
  esac
  if [ "$root" != "${dirs[0]}" ] && [ "$prune" -eq 1 ]; then
    prune_dangling "$root"
  fi

  local st=0
  for d in "${dirs[@]}"; do
    fix_dir "$d" || st=1
  done
  return $st
}

[ "$#" -eq 0 ] && set -- "$PWD"

status=0
for theme in "$@"; do
  fix_theme "$theme" || status=1
done

still=()
for m in "${missing[@]:-}"; do
  [ -n "$m" ] || continue
  d=${m%%::*}; n=${m#*::}
  dir_exists "$d" "$n" || still+=("$(basename -- "$d")/$n")
done
if [ "${#still[@]}" -gt 0 ]; then
  warn_msg "shapes the theme does not provide (no file to link to):"
  printf '    %s%s%s\n' "$C_DIM" "$(printf '%s\n' "${still[@]}" | sort -u | paste -sd' ' -)" "$C_RESET"
fi

suffix=''; [ "$dry_run" -eq 1 ] && suffix=' [dry-run]'
log "${C_DIM}done: $n_link links, $n_rm removals in $n_theme dirs$suffix${C_RESET}"

exit "$status"

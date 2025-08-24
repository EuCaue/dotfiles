#!/usr/bin/env zsh

# quick config files
alias gfg='nvim ~/.config/ghostty/config'
alias cfg='cd ~/.config/zsh/ && nvim ~/.config/zsh/.zshrc && cd -'
alias nfg='cd ~/.config/nvim/ && nvim ~/.config/nvim/init.lua && cd -'
alias tfg='cd ~/.config/tmux/ && nvim ~/.config/tmux/tmux.conf && cd -'
alias eh='sudoedit /etc/hosts'
alias disable_keyboard="sudo evtest"

# clear
alias c="clear"
alias cl="cd && c"

# git
alias g="git"
alias gg="gitu"
alias lg="lazygit"

# better ls
if command -v eza >/dev/null 2>&1; then
  alias la='eza -l -a -g --icons -h --group-directories-first --sort modified --reverse --hyperlink'
  alias ls='eza -l -g --icons -h --group-directories-first --sort modified --reverse --hyperlink'
fi
alias lc="ls | wc -l"
alias lll='ls'
alias yy="yazi"

# better rm
if command -v trash >/dev/null 2>&1; then
  alias rl='trash list'
  alias rm='trash put'
  alias rr='trash restore'
fi

# system
alias update-grub="sudo grub2-mkconfig -o /etc/grub2.cfg && sudo grub2-mkconfig -o /etc/grub2-efi.cfg"
alias ls-font='fc-list --format="%{family}\\n" | cut -d , -f 1 | sort | uniq | fzf'

function install-custom-theme() {
  TARGET_DIR="/usr/share/icons/"
  for theme in "$@"; do
    if [[ -e "$theme" ]]; then
      sudo mv "$theme" "$TARGET_DIR"
      echo "Installed $theme to $TARGET_DIR"
    else
      echo "Provide a valid cursor/icon folder/path: $theme"
    fi
  done
}

function set-cursor-theme() {
  local CURSOR_THEME="$1"
  [[ -z "$CURSOR_THEME" ]] && echo "Usage: set-cursor-theme <theme-name>" && return 1

  sed -i "s/^\(Inherits=\).*$/\1$CURSOR_THEME/" "$HOME/.local/share/icons/default/index.theme"
  export XCURSOR_THEME="$CURSOR_THEME"
  gsettings set org.gnome.desktop.interface cursor-theme "$CURSOR_THEME"

  if command -v flatpak >/dev/null 2>&1; then
    flatpak override --user --env=XCURSOR_THEME="$CURSOR_THEME"
  fi
}

function set-cursor-size() {
  local CURSOR_SIZE="$1"
  [[ -z "$CURSOR_SIZE" ]] && echo "Usage: set-cursor-size <size>" && return 1

  export XCURSOR_SIZE="$CURSOR_SIZE"
  gsettings set org.gnome.desktop.interface cursor-size "$CURSOR_SIZE"

  if command -v flatpak >/dev/null 2>&1; then
    flatpak override --user --env=XCURSOR_SIZE="$CURSOR_SIZE"
  fi
}
alias get-cursor-theme='gsettings get org.gnome.desktop.interface cursor-theme'
alias get-cursor-size='gsettings get org.gnome.desktop.interface cursor-size'
alias check-font-weight='echo -e "\e[1mbold\e[0m"; echo -e "\e[3mitalic\e[0m"; echo -e "\e[4munderline\e[0m"; echo -e "\e[9mstrikethrough\e[0m"; echo -e "\e[31mHello World\e[0m"'
alias test-font-weight='echo -e "\e[1mbold\e[0m"; echo -e "\e[3mitalic\e[0m"; echo -e "\e[4munderline\e[0m"; echo -e "\e[9mstrikethrough\e[0m"; echo -e "\e[31mHello World\e[0m"'
function change-alacritty-theme() {
  ln -fs ~/.config/alacritty/themes/$1.toml ~/.config/alacritty/themes/.active.toml
  sed -i 's/.active/.active1/' ~/.config/alacritty/themes/.active.toml &&
    sed -i 's/.active1/.active/' ~/.config/alacritty/themes/.active.toml
}

function timer() {
  notify-send -u normal \
    -i "/usr/share/icons/Adwaita/symbolic/categories/emoji-recent-symbolic.svg" \
    --app-name="Countdown" \
    "Countdown for $2" \
    "Countdown: $1"

  countdown "$1"

  notify-send -u normal \
    -i "/usr/share/icons/Adwaita/symbolic/categories/emoji-recent-symbolic.svg" \
    --app-name="Countdown" \
    "Countdown for $2" \
    "Countdown of $1 has been passed! =D"
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

# nvim
alias vi='nvim'
alias vim='nvim'
alias v='nvim'
alias vv="nvim ."
alias :q="exit"
alias :wq="exit"

# toggle file executable
mx() {
  for file in "$@"; do
    if [[ -x "$file" ]]; then
      chmod -x "$file"
    else
      chmod +x "$file"
    fi
  done
}

# extract files
x() {
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case $archive in
      *.tar.bz2) tar xvjf $archive ;;
      *.tar.gz) tar xvzf $archive ;;
      *.bz2) bunzip2 $archive ;;
      *.rar) rar x $archive ;;
      *.gz) gunzip $archive ;;
      *.tar) tar xvf $archive ;;
      *.tbz2) tar xvjf $archive ;;
      *.tgz) tar xvzf $archive ;;
      *.txz) tar xvzf $archive ;;
      *.zip) unzip $archive ;;
      *.Z) uncompress $archive ;;
      *.7z) 7z x $archive ;;
      *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

# tree with exa
t() {
  if [ $(command -v eza) ]; then
    dir=${1:(pwd)}
    echo $dir
    eza -l -a -g --icons --tree "${@:2}" $dir
  fi
}

# open neovim with markdownpreview
nm() {
  if [ $(command -v nvim) ]; then
    nvim "$1" -c MarkdownPreview
  fi
}

mkcd() {
  mkdir -p $1 && cd $1
}

f() {
  default_path=./
  path_to_open=${1:-$default_path}
  xdg-open $path_to_open >/dev/null 2>&1 &
  disown
}

gcl() {
  cd ~/gitclone && git clone --depth=1 "$1" && cd "$(basename "$1" .git)"
}

vf() {
  if [ $(command -v fzf) ]; then
    file=$(ls | fzf --prompt "Select File " --pointer "->" --multi)
    if [ -z "$file" ]; then
      echo "Select a file!"
      return 1
    fi
    v "$file"
    return 0
  fi
}

slugify() {
  if [[ -z "$1" ]]; then
    echo "Usage: slugify <filename>"
    return 1
  fi

  local filepath="$1"
  local dir=$(dirname "$filepath")
  local ext="${filepath##*.}"
  local base=$(basename "$filepath" ."$ext")

  # Slugify: lowercase, replace spaces with hyphens, remove special chars
  local slug=$(echo "$base" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g' | sed -E 's/^-+|-+$//g')

  local newpath="$dir/$slug.$ext"
  mv "$filepath" "$newpath"
  echo "Renamed to: $newpath"
}

toggle_comment_range() {
  local range="$1"
  local file="$2"
  local apply="${3:-false}" # true = apply changes, false = preview only

  if [[ -z "$range" || -z "$file" ]]; then
    echo "Usage: toggle_comment_range <start_line,end_line> <file> [true|false]"
    return 1
  fi

  # simulate the changes without modifying the file
  local new
  new=$(sed "${range}{
    s/^#//;
    t;
    s/^/#/
  }" "$file")

  # show only the changed lines
  diff <(cat "$file") <(echo "$new") | rg '^[<>]' | sed 's/^/> /'

  # apply changes if requested
  if [[ "$apply" == "true" ]]; then
    sudo sed -i "${range}{
      s/^#//;
      t;
      s/^/#/
    }" "$file"
    echo "Changes applied with sudo to $file."
  else
    echo "Preview only. No changes were applied. Pass 'true' as third argument to apply."
  fi
}

toggle_with_selection() {
  selection=$(cat --number /etc/hosts | fzf --multi | awk '{print $1}' | sort)
  first=$(echo "$selection" | head -n1)
  last=$(echo "$selection" | tail -n1)
  [ -z "$selection" ] && return
  range="$first,$last"
  toggle_comment_range "$range" /etc/hosts true
}

toggle_yt() {
  toggle_comment_range "24,27" /etc/hosts true
}

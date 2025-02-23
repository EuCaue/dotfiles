#!/usr/bin/env zsh

# quick config files
alias gfg='nvim ~/.config/ghostty/config'
alias cfg='cd ~/.config/zsh/ && nvim ~/.config/zsh/.zshrc && cd -'
alias nfg='cd ~/.config/nvim/ && nvim ~/.config/nvim/init.lua && cd -'
alias tfg='cd ~/.config/tmux/ && nvim ~/.config/tmux/tmux.conf && cd -'
alias disable_keyboard="sudo evtest --grab /dev/input/event23 > /dev/null 2>&1"

# clear
alias c="clear"
alias cl="cd && c"

# git
alias g="git"
alias gu="gitu"

# better ls
alias la='exa -l -a -g --icons -h --group-directories-first --sort modified --reverse --hyperlink'
alias lll='ls'
alias ls='exa -l -g --icons -h --group-directories-first --sort modified --reverse --hyperlink'
alias lc="ls | wc -l"

# better rm
alias rl='trash list'
alias rm='trash put'
alias rr="trash restore"

# system
alias update-grub="sudo grub2-mkconfig -o /etc/grub2.cfg && sudo grub2-mkconfig -o /etc/grub2-efi.cfg"
alias ls-font='fc-list --format="%{family}\\n" | cut -d , -f 1 | sort | uniq | fzf'

function install-custom-theme() {
  if [ "$(id -u)" -eq 0 ]; then
    TARGET_DIR="/usr/share/icons/"
  else
    TARGET_DIR="$HOME/.local/share/icons/"
  fi

  for theme in "$@"; do
    if [[ -e "$theme" ]]; then
      mv "$theme" "$TARGET_DIR"
      echo "Installed $theme to $TARGET_DIR"
    else
      echo "Provide a valid cursor/icon folder/path: $theme"
    fi
  done
}

alias set-cursor-theme='gsettings set org.gnome.desktop.interface cursor-theme '
alias set-cursor-size='gsettings set org.gnome.desktop.interface cursor-size '
alias get-cursor-theme='gsettings get org.gnome.desktop.interface cursor-theme'
alias get-cursor-size='gsettings get org.gnome.desktop.interface cursor-size'
alias check-font-weight='echo -e "\e[1mbold\e[0m"; echo -e "\e[3mitalic\e[0m"; echo -e "\e[4munderline\e[0m"; echo -e "\e[9mstrikethrough\e[0m"; echo -e "\e[31mHello World\e[0m"'
function change-alacritty-theme() {
  ln -fs ~/.config/alacritty/themes/$1.toml ~/.config/alacritty/themes/.active.toml
  sed -i 's/.active/.active1/' ~/.config/alacritty/themes/.active.toml &&
    sed -i 's/.active1/.active/' ~/.config/alacritty/themes/.active.toml
}

function timer() {
  # Envia a primeira notificação
  notify-send -u normal \
    -i "/usr/share/icons/Adwaita/symbolic/categories/emoji-recent-symbolic.svg" \
    --app-name="Countdown" \
    "Countdown for $1" \
    "Countdown: $2"

  countdown "$2"

  notify-send -u normal \
    -i "/usr/share/icons/Adwaita/symbolic/categories/emoji-recent-symbolic.svg" \
    --app-name="Countdown" \
    "Countdown for $1" \
    "Countdown of $2 has been passed! =D"
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
treez() {
  if [ $(command -v exa) ]; then
    default_level=2
    tree_level=${1:-$default_level}
    exa -l -a -g --icons --tree --level=$default_level
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

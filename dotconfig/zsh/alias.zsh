#!/usr/bin/env zsh

# quick config files
alias afg='nvim ~/.config/alacritty/alacritty.toml'
alias cfg='cd ~/.config/zsh/ && nvim ~/.config/zsh/.zshrc && cd -'
alias nfg='cd ~/.config/nvim/ && nvim ~/.config/nvim/init.lua && cd -'
alias tfg='cd ~/.config/tmux/ && nvim ~/.config/tmux/tmux.conf && cd -'
alias disable_keyboard="sudo evtest --grab /dev/input/event25 > /dev/null 2>&1"

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
alias set-cursor-theme='gsettings set org.gnome.desktop.interface cursor-theme '
alias set-cursor-size='gsettings set org.gnome.desktop.interface cursor-size '
alias get-cursor-theme='gsettings get org.gnome.desktop.interface cursor-theme'
alias get-cursor-size='gsettings get org.gnome.desktop.interface cursor-size'

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

#!/bin/sh

neofetch --kitty ~/Pictures/wallpapers\ mobile/wallhaven-9m9dqk.jpg
export PATH="$HOME/.local/bin:$PATH"
ZSH_AUTOSUGGEST_STRATEGY=(history)
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/caue/.zshrc'
autoload -Uz compinit
compinit
bindkey '^ ' autosuggest-accept


# NOTE: Plugins
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "zap-zsh/vim"
plug "skywind3000/z.lua"

source ~/.config/zsh/alias.zsh
source ~/.config/zsh/exports.zsh

eval "$(starship init zsh)"

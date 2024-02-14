#!/bin/sh

export PATH="$HOME/.local/bin:$PATH"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob notify HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
unsetopt beep
bindkey -v
zstyle :compinstall filename '/home/caue/.zshrc'
autoload -Uz compinit
compinit
bindkey '^ ' autosuggest-accept


# NOTE: Plugins
[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"
# plug "zap-zsh/supercharge"
plug "zsh-users/zsh-autosuggestions"
plug "zsh-users/zsh-syntax-highlighting"
# plug "hlissner/zsh-autopair"
# plug "zap-zsh/vim"
# plug "skywind3000/z.lua"
plug "joshskidmore/zsh-fzf-history-search"


source ~/.config/zsh/alias.zsh
source ~/.config/zsh/exports.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh )" 


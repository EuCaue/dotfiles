#!/usr/bin/env zsh
# best thing
echo -en '\e]22;ibeam\e\\'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# plugins
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "z-shell/F-Sy-H"
plug 'wfxr/forgit'
plug "jeffreytse/zsh-vi-mode"
plug "$ZDOTDIR/alias.zsh"
plug "$ZDOTDIR/exports.zsh"
plug "$ZDOTDIR/keybinds.zsh"
plug "$ZDOTDIR/fix.zsh"
plug "$ZDOTDIR/dot-dot.zsh"
plug "$ZDOTDIR/sudo-it.zsh"
plug "/usr/share/fzf/shell/completion.zsh"
plug "MenkeTechnologies/zsh-cargo-completion"

# setopt
setopt INC_APPEND_HISTORY

# completion for custom aliases
compdef _files mx
compdef _files extract
compdef _files nm
compdef _pgrep killall

_git-bc() {
	_git-branch
}

compdef _git-bc git-bc

# Load zsh-completions if installed manually
fpath+=~/.zsh/zsh-completions/src

# Enable completion system
autoload -U compinit
compinit

if [ $(command -v procs) ]; then
	zstyle ':completion:*:*:kill:*:processes' command 'procs'
else
	zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,user:10,cmd'
fi

zstyle ':completion:*:*:git:*' user-commands bc:'Checkout or switch to a branch'
# eval
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# bun completions
[ -s "/home/caue/.bun/_bun" ] && source "/home/caue/.bun/_bun"

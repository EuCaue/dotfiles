#!/usr/bin/env zsh
# best thing
echo -en '\e]22;ibeam\e\\'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "z-shell/F-Sy-H"
plug "zsh-users/zsh-history-substring-search"
plug "laurenkt/zsh-vimto"

source "$ZDOTDIR/sane.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/keybinds.zsh"
source "$ZDOTDIR/dot-dot.zsh"
source "$ZDOTDIR/sudo-it.zsh"
source "$ZDOTDIR/compdefs.zsh"
source <(fzf --zsh) 

# bun completions
[ -s "/home/caue/.bun/_bun" ] && source "/home/caue/.bun/_bun"

# eval's
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

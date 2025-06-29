#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# best thing
echo -en '\e]22;text\e\\'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#4A4A4A,bg=bold"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
# plug "romkatv/powerlevel10k"
plug "Aloxaf/fzf-tab"
plug "zsh-users/zsh-autosuggestions"
plug "z-shell/F-Sy-H"
plug "zsh-users/zsh-history-substring-search"
plug "jeffreytse/zsh-vi-mode"
source "$ZDOTDIR/sane.zsh"
source "$ZDOTDIR/alias.zsh"
source "$ZDOTDIR/exports.zsh"
source "$ZDOTDIR/keybinds.zsh"
source "$ZDOTDIR/dot-dot.zsh"
source "$ZDOTDIR/sudo-it.zsh"
source "$ZDOTDIR/compdefs.zsh"
# source <(fzf --zsh)
ZVM_CURSOR_STYLE_ENABLED=false
zvm_after_init_commands+=('source <(fzf  --zsh)')

# bun completions
[ -s "/home/caue/.bun/_bun" ] && source "/home/caue/.bun/_bun"

# eval's
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

for al in $(git --list-cmds=alias); do
  alias g$al="git $al"
done

# To customize prompt, run `p10k configure` or edit ~/dotfiles/dotconfig/zsh/.p10k.zsh.
# [[ ! -f ~/dotfiles/dotconfig/zsh/.p10k.zsh ]] || source ~/dotfiles/dotconfig/zsh/.p10k.zsh
# eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/bubbles.omp.json)"
# eval "$(fnm env --use-on-cd --shell zsh)"

# pnpm
export PNPM_HOME="/home/caue/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

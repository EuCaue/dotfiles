# nvim_was_opened=false
#
# enable_mouse() {
# 	if [ -n "$TMUX" ] && $nvim_was_opened; then
# 		fish -c "tmux set-option -g mouse on"
# 	fi
# }
#
# disable_mouse() {
# 	if [ $1 = "v" ] || [ $1 = "nvim" ]; then
# 		fish -c "tmux set-option -g mouse off"
# 		nvim_was_opened=true
# 		return 0
# 	fi
# 	nvim_was_opened=false
# 	return 0
# }
#
# autoload -Uz add-zsh-hook          # load add-zsh-hook with zsh (-z) and suppress aliases (-U)
# add-zsh-hook precmd enable_mouse   # hook custom_func into the precmd hook
# add-zsh-hook preexec disable_mouse # hook custom_func into the precmd hook

# Fix zsh-vi-mode disabling fzf key bindings
function my_init() {
	[ -f "/usr/share/fzf/shell/key-bindings.zsh" ] && plug "/usr/share/fzf/shell/key-bindings.zsh"
}
zvm_after_init_commands+=(my_init)

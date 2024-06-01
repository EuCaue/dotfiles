#!/usr/bin/zsh

function expand-dots() {
	local MATCH
	if [[ $LBUFFER =~ '(^|/| |      |'$'\n''|\||;|&)\.\.$' && ! $LBUFFER = p4* ]]; then
		LBUFFER+=/..
	else
		zle self-insert
	fi
}
zle -N expand-dots
bindkey '.' expand-dots

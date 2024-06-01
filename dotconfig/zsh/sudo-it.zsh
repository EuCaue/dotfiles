#!/usr/bin/env zsh

function sudo-it() {
	if [[ -z "$LBUFFER" && -z "$RBUFFER" && "$LBUFFER" != sudo ]]; then
		if [[ "$LBUFFER" != sudo\ * ]]; then
			zle up-history
			LBUFFER="sudo $LBUFFER"
			zle end-of-line
		fi
	else
		if [[ "$LBUFFER" != sudo\ * ]]; then
			LBUFFER="sudo $LBUFFER"
			zle end-of-line
		fi
	fi
}

sudo-it-paste() {
	LBUFFER="sudo $(wl-paste)"
	zle end-of-line
}

zle -N sudo-it
zle -N sudo-it-paste

bindkey "\es" sudo-it
bindkey "\ep" sudo-it-paste

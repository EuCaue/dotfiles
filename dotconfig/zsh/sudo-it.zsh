#!/usr/bin/env zsh

function sudo-it() {
  echo $BUFFER
  if [[ -z $BUFFER ]]; then
    zle up-history
    [[ -z $BUFFER ]] && { BUFFER='sudo '; CURSOR=${#BUFFER}; zle reset-prompt; return 0; }
  fi

  [[ $BUFFER =~ ^[[:space:]]*sudo([[:space:]]|$) ]] && return 0

  BUFFER="sudo $BUFFER"
  CURSOR=$(( CURSOR + 5 ))
  zle reset-prompt
  return 0
}

sudo-it-paste() {
	LBUFFER="sudo $(wl-paste)"
	zle end-of-line
}

zle -N sudo-it
zle -N sudo-it-paste

bindkey -e "\es" sudo-it
bindkey -e "\ep" sudo-it-paste
bindkey -v "\es" sudo-it
bindkey -v "\ep" sudo-it-paste
bindkey -a "\es" sudo-it
bindkey -a "\ep" sudo-it-paste

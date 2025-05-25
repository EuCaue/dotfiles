# completion for custom aliases
compdef _files mx
compdef _files extract
compdef _files nm
compdef _pgrep killall

_git-bc() {
	_git-branch
}

compdef _git-bc git-bc

if [ $(command -v procs) ]; then
  zstyle ':completion:*:*:kill:*:processes' command 'procs'
else
  zstyle ':completion:*:*:kill:*:processes' command 'ps xo pid,user:10,cmd'
fi

zstyle ':completion:*:*:git:*' user-commands bc:'Checkout or switch to a branch'

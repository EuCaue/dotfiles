# quick config files
alias afg='nvim ~/.config/alacritty/alacritty.toml && prevd'
alias cfg='cd ~/.config/fish/ && nvim ~/.config/fish/config.fish && prevd'
alias nfg='cd ~/.config/nvim/ && nvim ~/.config/nvim/init.lua && prevd'
alias tfg='cd ~/.config/tmux/ && nvim ~/.config/tmux/tmux.conf && prevd'

# clear
alias c="clear"
alias cl="cd && c"

# git
alias g="git"
alias gu="gitu"

# better ls
alias la='exa -l -a -g --icons -h --group-directories-first --sort modified --reverse '
alias lll='ls'
alias ls='exa -l -g --icons -h --group-directories-first --sort modified --reverse '
alias lc="ls | wc -l"

# better rm
alias rl='trash list'
alias rm='trash put'
alias rr="trash restore"

# system
alias li='free -h && sudo limpante && free -h'
alias update-grub="sudo grub2-mkconfig -o /etc/grub2.cfg && sudo grub2-mkconfig -o /etc/grub2-efi.cfg"

# nvim
alias vi='nvim'
alias vim='nvim'
alias v='nvim'
alias vv="nvim ."
alias :q="exit"
alias :wq="exit"

function tree --description "Show list tree view for files"
    if test -z $argv[1]
        exa -l -a -g --icons --tree
    else
        exa -l -a -g --icons --tree --level=$argv[1]
    end
end

function nm --descriptio "Open file with neovim and markdown preview"
    nvim "$argv[1]" -c MarkdownPreview
end

function mkcd --description "mkdir with cd"
    mkdir -p $argv[1] && cd $argv[1]
end

function f --description "Open current dir with file manager"
    xdg-open ./ >/dev/null 2>&1 & disown
end

function gcl --description "Clone in gitclone folder and cd into it"
    cd ~/gitclone; and git clone --depth=1 $argv && cd (basename $argv[1] .git)
    return 0
end

function vf --description "Open selected files in fzf with nvim"
    ls | set file $(fzf --prompt "Select File " --pointer "->" --multi)
    if test -z $file
        echo "Select a file!"
        return 1
    end
    v $file
    return 0
end

function pomoc --description "Pomodoro with count" -a count pomo_name
    if test -z $pomo_name
        set argv[2] default
        set pomo_name default
    end
    for i in (seq $count)
        notify-send --expire-time=5000 Pomo "Starting $pomo_name $i/$count"
        pomof $pomo_name && pomof break
    end
end

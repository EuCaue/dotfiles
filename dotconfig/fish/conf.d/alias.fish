# NOTE: most used
alias cfg='cd ~/.config/fish/ && nvim ~/.config/fish/config.fish && cd'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias afg='nvim ~/.config/alacritty/alacritty.toml'
alias ffg="nvim ~/.config/foot/foot.ini"
alias hfg='nvim ~/.config/hypr/'
alias nft='nvim ~/.config/neofetch/config.conf'
alias nfg='cd ~/.config/nvim/ && nvim ~/.config/nvim/init.lua && prevd'
alias wfg='cd ~/.config/wezterm/ && nvim ~/.config/wezterm/wezterm.lua && prevd'
alias tfg='cd ~/.config/tmux/ && nvim ~/.config/tmux/tmux.conf && prevd'
alias sus='paru'
alias c="clear"
alias cf="ls | wc -l"

alias pwo="pomo 'work'"
alias pbr="pomo 'break'"
alias pla="pomo 'lang'"

function pomoc --description "pomo with count and pomo time" -a count pomo_name
    if test -z $pomo_name
        set argv[2] default
        set pomo_name default
    end
    for i in (seq $count)
        notify-send --expire-time=5000 Pomo "Starting $pomo_name $i/$count"
        pomof $pomo_name && pomof break
    end
end

function gal --description "alias git add commit push"
    git add .
    git status
    read -P 'commit:' commit
    git commit -m "$commit"
    git push
    return 0
end

alias bat='bat --theme=base16'
alias ls='exa -l -g --icons -h --group-directories-first --sort modified --reverse '
alias la='exa -l -a -g --icons -h --group-directories-first --sort modified --reverse '
alias lll='ls'

function lr --description "Show a tree file"
    if test -z $argv[1]
        exa -l -a -g --icons --tree --level=2
    else
        exa -l -a -g --icons --tree --level=$argv[1] $argv[2]
    end
    return 0
end

alias rn="mv"
alias rm='trash put'
alias rl='trash list'
alias rr="trash restore"
alias tree="exa -l -a -g --icons --tree"
alias cl="cd && c"
# function unzip --description "unzip and delete the zip file"
#     /usr/bin/unzip $argv[1] -d $(basename -s .zip $argv[1])
# end

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias vv="nvim ."
alias clearpkg='sus -Qtdq | sus -Rns -'
alias dumpkgs='sus -Qq > $HOME/dotfiles/pkgs.txt'

function stats --description "Show custom variables"
    echo "Cursor: $CURSOR"
    echo "Cursor Size: $CURSORSIZE"
    echo "Font: $FONT_NAME"
end

function mkcd --description "mkdir with cd"
    mkdir -p $argv[1] && cd $argv[1]
end

function gcl --description "Clone to gitclone folder and cd"
    cd ~/gitclone; and git clone --depth=1 $argv && cd (basename $argv[1] .git)
    return 0
end

function vf --description "open in nvim with fzf "
    ls | set file $(fzf --prompt "Select File " --pointer "->" --multi)
    if test -z $file
        echo "Select a file!"
        return 1
    end
    v $file
    return 0
end

alias r='yazi'
alias g="git"
alias gg='lazygit'
alias :wq="exit"
alias :q="exit"
alias cr="cargo run"
alias wf='wfetch'
alias remirror='sudo reflector -c BR -f 2 -l 20 -n 10 --save /etc/pacman.d/mirrorlist'

function img --description "Display image"
    if test "$TERM" = foot; or test "$TERM" = xterm-256color; or test "$TERM" = alacritty
        img2sixel $argv
        return
    end

    if test "$TERM" = wezterm
        wezterm imgcat $argv
        return
    end

    if test "$TERM" = xterm-kitty
        kitty +kitten icat --align=left $argv
        return
    end
    chafa $argv
end

function imgall --description "display all images in the current folder"
    for file in ./*.{jpg, png}
        img $file
    end
    return 0
end

function pc --description "better copy command"
    eval $argv | wl-copy
end

function mv_tmp_wall --description "Move tmp wallpaper to wallpapers folder"
    mv $HOME/.local/share/backgrounds/* $HOME/Pictures/wallpapers/
end

function mvcur --description "Move cursor to icons folder"
    if test -z $argv[1]
        echo "Provide a cursor folder/path"
        return 1
    end

    if test (count $argv) -gt 0
        for folder in $argv
            sudo mv $folder /usr/share/icons/
        end
        return 0
    else
        echo "Provide a folder"
        return 1
    end
end

# just make Interactive
alias mv='mv -i'
alias cp='cp -i'


# NOTE: WebDev
function vited --description "alias vite and firefox"
    if not pgrep -f firefox-developer-edition >/dev/null
        firefox-developer-edition >/dev/null 2>&1 & disown
    end
    yarn vite --host
    return 0
end


# NOTE: System
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias li='free -h && sudo limpante && free -h'

function f --description "open file manager in current dir"
    thunar . >/dev/null 2>&1 & disown
end

# NOTE: Random 

alias susa='paru -Syua'
# alias csgoc='sed -i -e "/kb_options/s/^#*/#/" dotfiles/dotconfig/hypr/hyprland.conf'
# alias csgocc='sed -i -e "/kb_options/s/^#//" dotfiles/dotconfig/hypr/hyprland.conf'
# alias suslol='sudo sh -c "sysctl -w abi.vsyscall32=0"'
# alias mann='read -S -P 'man:' manpage && man $manpage | nvim'

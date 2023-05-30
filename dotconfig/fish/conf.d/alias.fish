# NOTE: most used
alias cfg='cd ~/.config/fish/ && nvim ~/.config/fish/config.fish && cd'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias afg='nvim ~/.config/alacritty/alacritty.yml'
alias ffg="nvim ~/.config/foot/foot.ini"
alias hfg='nvim ~/.config/hypr/hyprland.conf'
alias nft='nvim ~/.config/neofetch/config.conf'
alias nfg='cd ~/.config/nvim/ && nvim ~/.config/nvim/init.lua && cd'
alias wfg='cd ~/.config/wezterm/ && nvim ~/.config/wezterm/wezterm.lua && cd'
alias sus='paru'
function gal --description "alias git add commit push"
    git add .
    git status
    read -P 'commit:' commit
    git commit -m "$commit"
    git push
    return 0
end
alias bat='bat --theme=base16'
alias ls='exa -l -g --icons'
alias la='exa -l -a -g --icons'
alias lll='exa -l -a -g --icons'
function lr --description "Show a tree file"
    if test -z $argv[1]
        exa -l -a -g --icons --tree --level=2
    else
        exa -l -a -g --icons --tree --level=$argv[1]
    end
    return 0
end
alias rm='rmtrash -i'
alias rf='rmtrash -r -I'

alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias clearpkg='sus -Qtdq | sus -Rns -'
alias dumpkgs='sus -Qq > $HOME/dotfiles/pkgs.txt'
function gcl --description "Clone to gitclone folder and cd"
    cd ~/gitclone; and git clone $argv[1] && cd (basename $argv[1] .git)
    return 0
end

function vf --description "open in nvim with fzf "
    ls | set file $(fzf)
    if test -z $file
        echo "Select a file!"
        return 1
    end
    v $file
    return 0
end
alias r='ranger'
alias g='lazygit'
alias gw='glow'
alias :wq="exit"
alias :q="exit"
alias cr="cargo run"
alias wf='wfetch'
alias remirror='sudo reflector -c BR -f 2 -l 20 -n 10 --save /etc/pacman.d/mirrorlist'
function img --description "Display image"
    if test "$TERM" = foot
        img2sixel $argv
        return
    end

    if test "$TERM" = wezterm
        wezterm imgcat $argv
        return
    end

    if test "$TERM" = xterm-kitty
        kitty +kitten icat $argv
        return
    end
    echo "Terminal not supported"
end

function imgall --description "display all images in the current folder"
    for file in ./*.{jpg, png}
        img $file
    end
    return 0
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
# alias rm='rm -i'
alias cp='cp -i'


# NOTE: WebDev
function vited --description "alias vite and firefox"
    if not pgrep -f firefox-developer-edition >/dev/null
        firefox-developer-edition >/dev/null 2>&1 & disown
    end
    yarn vite --host
    return 0
end

alias yarns='yarn start'
alias yarnd='yarn run dev'
alias vercelp='yarn vercel --prod'
# ----------------------------------


# NOTE: System
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias li='free -h && sudo limpante && free -h'
alias f='free -h'

# NOTE: Random 
alias csgoc='sed -i -e "/kb_options/s/^#*/#/" dotfiles/dotconfig/hypr/hyprland.conf'
alias csgocc='sed -i -e "/kb_options/s/^#//" dotfiles/dotconfig/hypr/hyprland.conf'
alias susa='paru -Syua'
alias suslol='sudo sh -c "sysctl -w abi.vsyscall32=0"'
alias mann='read -S -P 'man:' manpage && man $manpage | nvim'



bind yy fish_clipboard_copy
bind Y fish_clipboard_copy
bind p fish_clipboard_paste

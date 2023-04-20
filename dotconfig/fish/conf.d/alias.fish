# NOTE: most used
alias cfg='nvim ~/.config/fish/config.fish'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias ffg="nvim ~/.config/foot/foot.ini"
alias hfg='nvim ~/.config/hypr/hyprland.conf'
alias nft='nvim ~/.config/neofetch/config.conf'
alias nfg='nvim ~/.config/nvim/init.lua'
alias sus='paru'
# alias gal='git add . && read -P 'commit:' commit && git commit -m "$commit" && git push' 
function gal --description "alias git add commit push"
    git add .
    git status
    read -P 'commit:' commit
    git commit -m "$commit"
    git push
end

alias bat='bat --theme=base16'
alias ls='exa -l -g --icons'
alias la='exa -l -a -g --icons'
alias lll='exa -l -a -g --icons'
alias rf='rm -rf'
alias vim='nvim'
alias lwaybar='killall waybar && waybar & disown'
alias vi='nvim'
alias clearpkg='sus -Qtdq | sus -Rns -'
alias dumpkgs='sus -Qq > $HOME/dotfiles/pkgs.txt'
function gcl --description "Clone to gitclone folder and cd"
    cd ~/gitclone; and git clone $argv[1] && cd (basename $argv[1] .git)
end
alias gcld='cd ~/Dev && git clone'
alias v='nvim'
alias vf='ls | set file $(fzf) & vi $file'
alias r='ranger'
alias g='lazygit'
alias gw='glow'
alias :wq="exit"
alias :q="exit"
alias cr="cargo run"
alias wf='wfetch'
alias remirror='sudo reflector -c BR -f 2 -l 20 -n 10 --save /etc/pacman.d/mirrorlist'
alias img='img2sixel --width=800 --height=600'
function imgall --description "display all images in the current folder"
    for file in ./*.{jpg, png}
        img $file
    end
end

function mvcur --description "Move cursor to icons folder"
    if test -z $argv[1]
        echo "Provide a cursor folder/path"
        return 0
    end
    if test -d $argv[1]
        sudo mv $argv[1] /usr/share/icons/
        return 1
    else
        echo "Provide a folder"
        return 0
    end
end

# just make Interactive
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'


# NOTE: WebDev
function vited --description "alias vite and firefox"
    if not pgrep -f firefox-developer-edition >/dev/null
        firefox-developer-edition >/dev/null 2>&1 & disown
    end
    yarn vite --host
end

alias yarns='yarn start'
alias yarnd='yarn run dev'
alias vercelp='yarn vercel --prod'
# ----------------------------------


# NOTE: System
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias timepkg='ls -htl /var/lib/pacman/local/ &| less'
alias icat="kitty +kitten icat"
alias li='free -h && sudo limpante && free -h'
alias f='free -h'
alias rmlinks='find -maxdepth 1 -type l -delete'

# NOTE: Random 
alias csgoc='sed -i -e "/kb_options/s/^#*/#/" dotfiles/dotconfig/hypr/hyprland.conf'
alias csgocc='sed -i -e "/kb_options/s/^#//" dotfiles/dotconfig/hypr/hyprland.conf'
alias susa='paru -Syua'
alias suslol='sudo sh -c "sysctl -w abi.vsyscall32=0"'
alias mann='read -S -P 'man:' manpage && man $manpage | nvim'

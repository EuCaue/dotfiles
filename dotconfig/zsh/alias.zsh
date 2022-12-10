# NOTE: most used
alias cfg='nvim ~/.zshrc'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias hfg='nvim ~/.config/hypr/hyprland.conf'
alias nft='nvim ~/.config/neofetch/config.conf'
alias nfg='nvim ~/.config/nvim/init.lua'
alias sus='paru'
# alias gal='git add . && read -P 'commit:' commit && git commit -m "$commit" && git push' 
# function gal --description "alias git add commit push"
#     git add .
#     git status
#     read -P 'commit:' commit
#     git commit -m "$commit"
#     git push
# end
gal() {
  git add . 
  git status
  vared -p 'commit:' -c commit 
  git commit -m "$commit"
  git push
}

alias bat='bat --theme=base16'
alias ls='exa -l -g --icons'
alias ll='exa -l -g --icons'
alias la='exa -l -a -g --icons'
alias vim='nvim'
alias vi='nvim'
alias clearpkg='sus -Qtdq | sus -Rns -'
alias dumpkgs='sus -Qq > $HOME/dotfiles/pkgs.txt'
alias gcl='cd ~/gitclone && git clone'
alias gcld='cd ~/Dev && git clone'
alias c='cursor.fish'
alias v='nvim'
alias r='ranger'
alias g='lazygit'

# just make Interactive
alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'


# NOTE: WebDev
alias vited='npx vite --host'
alias npms='npm start'
alias npmd='npm run dev'
alias vercelp='npx vercel --prod'
# ----------------------------------


# NOTE: System
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias timepkg='ls -htl /var/lib/pacman/local/ &| less'
alias icat="kitty +kitten icat"
alias li='free -h && sudo limpante && free -h'
alias f='free -h'
alias rmlinks='find -maxdepth 1 -type l -delete'

# NOTE: Random 
alias susa='paru -Syua'
alias suslol='sudo sh -c "sysctl -w abi.vsyscall32=0"'
alias mobile='scrcpy -b 12M -m 1024 --tcpip=192.168.1.154'
alias mann='read -S -P 'man:' manpage && man $manpage | nvim'

# Init startship prompt
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
	  set fish_greeting  I use arch BTW 
    neofetch --chafa --source ~/Pictures/her/IMG-20221002-WA0015.jpg
end
# Disable fish greeting
#neofetch --ascii --source ~/.config/neofetch/anime.txt

 # Alias for commands
alias cfg='nvim ~/.config/fish/config.fish'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias nft='nvim ~/.config/neofetch/config.conf'
alias icat="kitty +kitten icat"
alias update='paru && flatpak update'
alias updatel='paru -Syu --color=always | tee -a .update.log && flatpak update | tee -a .update.log && date >> .update.log && echo "" >> .update.log '
#alias updatel='sudo pacman -Syu --color=always | tee .update.log && paru -Sua && flatpak update | tee -a .update.log && date >> .update.log'
alias updater='paru && flatpak update && kill firefox && reboot'
alias gte='gnome-text-editor'
alias li='free -h && sudo limpante && free -h'
alias f='free -h'
alias npms='npm start'
alias npmd='npm run dev'
alias gcl='cd ~/gitclone && git clone' 
alias sus='paru'
alias susa='paru -Syua'
alias suslol='sudo sh -c "sysctl -w abi.vsyscall32=0"'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mann='read -S -P 'man:' manpage && man $manpage | nvim'
alias gal='git add . && read -P 'commit:' commit && git commit -m "$commit" && git push' 
alias javajava='la && read -P 'file.java:' filejava -S && java $filejava.java'
alias javajar='la && read -P 'file.jar:' file -S && java -jar $file.jar'
alias clearpkg='sus -Qtdq | sus -Rns -'
alias vited='npx vite --host'
alias mobile='scrcpy -b 12M -m 1024 --tcpip=192.168.1.154'
alias fs='flatpak search '
alias ll='exa -l -g --icons'
alias vim='nvim'
alias vi='nvim'


# Remove all the symlink in the folder
alias rmlinks='find -maxdepth 1 -type l -delete'

# Theme for gnome-terminal
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Flatpak session
alias fup='flatpak update'
alias frm='flatpak uninstall --unused'
alias ftam='flatpak --columns=name,size list'
alias fli='sudo rm -rfv /var/tmp/flatpak-cache-*'


set QT_QPA_PLATFORM wayland
export MOZ_ENABLE_WAYLAND=1
set MOZ_ENABLE_WAYLAND 1
# Para usar o tema do Qgnomeplatform para QT
set QT_QPA_PLATFORMTHEME gnome

# Usando o tema do qt5ct para temas QT
#export QT_QPA_PLATFORMTHEME=qt5ct
#set QT_STYLE_OVERRIDE kvantum

#set QT_SCALE_FACTOR 0.90




# Exporting the default $EDITOR
export EDITOR=/usr/bin/nvim
export VISUAL=nvim



# *FETCH'S
#freshfetch
#uwufetch
#ufetch
#neofetch | lolcat
#pfetch | lolcat
#pfetch
#bfetch | lolcat
#fastfetch | lolcat
#afetch | lolcat
#free -h

### PFETCH CONFIG
#export PF_INFO="title os host kernel uptime pkgs memory"


alias hfg='nvim ~/.config/hypr/hyprland.conf'

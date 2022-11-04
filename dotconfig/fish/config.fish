# Init startship prompt
if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
	  set fish_greeting   I use arch BTW 
    # neofetch --chafa --source ~/Pictures/her/IMG-20221002-WA0015.jpg
    neofetch --kitty ~/dotfiles/dotconfig/neofetch/wallhaven-47wrlo.jpg
end
# Disable fish greeting

# NOTE: Alias for commands

# NOTE: most used
alias cfg='nvim ~/.config/fish/config.fish'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias hfg='nvim ~/.config/hypr/hyprland.conf'
alias nft='nvim ~/.config/neofetch/config.conf'
alias nfg='nvim ~/.config/nvim/init.lua'
alias sus='paru'
alias gal='git add . && read -P 'commit:' commit && git commit -m "$commit" && git push' 
alias ls='exa -l -g --icons'
alias la='exa -l -a -g --icons'
alias vim='nvim'
alias vi='nvim'
alias clearpkg='sus -Qtdq | sus -Rns -'
alias gcl='cd ~/gitclone && git clone' 

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
alias javajava='la && read -P 'file.java:' filejava -S && java $filejava.java'
alias javajar='la && read -P 'file.jar:' file -S && java -jar $file.jar'

# NOTE: Unused
# alias fup='flatpak update'
# alias frm='flatpak uninstall --unused'
# alias ftam='flatpak --columns=name,size list'
# alias fli='sudo rm -rfv /var/tmp/flatpak-cache-*'
# alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'
# alias gte='gnome-text-editor'
# alias update='paru && flatpak update'
# alias updatel='paru -Syu --color=always | tee -a .update.log && flatpak update | tee -a .update.log && date >> .update.log && echo "" >> .update.log '
# alias updater='paru && flatpak update && kill firefox && reboot'
# ----------------------------------------------------------------
# NOTE: and of alias


# NOTE: QT/Wayland
set QT_QPA_PLATFORM wayland
export MOZ_ENABLE_WAYLAND=1
set MOZ_ENABLE_WAYLAND 1
set QT_QPA_PLATFORMTHEME gnome
export QT_QPA_PLATFORMTHEME=gnome

# Exporting the default $EDITOR
export EDITOR=/usr/bin/nvim
export VISUAL=nvim

fish_add_path /home/caue/.spicetify

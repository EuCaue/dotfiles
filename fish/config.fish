# Init startship prompt
starship init fish | source
# Disable fish greeting
set fish_greeting I use arch BTW 
neofetch --ascii --source ~/.config/neofetch/anime.txt
export TERM=kitty

 # Alias for commands
alias cfg='nvim ~/.config/fish/config.fish'
alias kfg='nvim ~/.config/kitty/kitty.conf'
alias hfg='nvim ~/.config/hypr/hyprland.conf'
alias nft='nvim ~/.config/neofetch/config.conf'
alias update='paru && flatpak update'
alias gte='gnome-text-editor'
alias li='free -h && sudo limpante && free -h'
alias f='free -h'
alias npms='npm start'
alias npmd='npm run dev'
alias gcl='cd ~/gitclone && git clone '
alias sus='paru'
alias susa='paru -Syua'
alias suslol='sudo sh -c "sysctl -w abi.vsyscall32=0"'
# Remove all the symlink in the folder
alias rmlinks='find -maxdepth 1 -type l -delete'

alias a='echo "hello world"'

# Theme for gnome-terminal
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Flatpak session
alias fup='flatpak update'
alias frm='flatpak uninstall --unused'
alias ftam='flatpak --columns=name,size list'
alias fli='sudo rm -rfv /var/tmp/flatpak-cache-*'



set QT_QPA_PLATFORM wayland
set MOZ_ENABLE_WAYLAND 1
# Para usar o tema do Qgnomeplatform para QT
#set QT_QPA_PLATFORMTHEME gnome

# Usando o tema do qt5ct para temas QT
#export QT_QPA_PLATFORMTHEME=qt5ct
#set QT_STYLE_OVERRIDE kvantum

#set QT_SCALE_FACTOR 0.80
export GTK_THEME=Gruvbox-Dark


set QT_QPA_PLATFORMTHEME qt5ct


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



# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end


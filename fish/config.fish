# Init startship prompt
starship init fish | source
# Disable fish greeting
set fish_greeting
 
 # Alias for commands
alias cfg='nvim ~/.config/fish/config.fish'
alias update='paru && flatpak update'
alias gte='gnome-text-editor'
alias li='free -h && sudo limpante && free -h'
alias f='free -h'

# Theme for gnome-terminal
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'

# Flatpak session
alias fup='flatpak update'
alias frm='flatpak uninstall --unused'
alias ftam='flatpak --columns=name,size list'
alias fli='sudo rm -rfv /var/tmp/flatpak-cache-*'

# Exporting the default $EDITOR
export EDITOR=/bin/nano
export VISUAL=nano



# *FETCH'S
#freshfetch
#ufetch
#neofetch | lolcat
#pfetch | lolcat
#bfetch | lolcat
#fastfetch | lolcat
#afetch | lolcat
#free -h

# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end


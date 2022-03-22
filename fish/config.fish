# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

set fish_greeting 

#freshfetch
#ufetch
#neofetch | lolcat
#pfetch | lolcat
#bfetch | lolcat
#fastfetch | lolcat
#afetch | lolcat
#free -h
alias hi='echo "Hello World"'
alias li='sudo limpante'
alias discord='flatpak run com.discordapp.Discord'
alias gte='gnome-text-editor'
alias update='paru && flatpak update'

#alias aura="sudo aura"
export EDITOR=/bin/nano
export VISUAL=nano

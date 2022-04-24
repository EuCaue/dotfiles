# Start X at login
if status is-login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
        exec startx -- -keeptty
    end
end

starship init fish | source

set fish_greeting
 

#freshfetch
#ufetch
#neofetch | lolcat
#pfetch | lolcat
#bfetch | lolcat
#fastfetch | lolcat
#afetch | lolcat
#free -h
alias cfg='nvim ~/.config/fish/config.fish'
alias hi='echo "Hello World"'
alias li='free -h && sudo limpante && free -h'
alias gte='gnome-text-editor'
alias update='paru && flatpak update'
alias f='free -h'
alias gogh='bash -c "$(wget -qO- https://git.io/vQgMr)"'
alias ftam='flatpak --columns=name,size list'
alias fli='sudo rm -rfv /var/tmp/flatpak-cache-*'
alias frm='flatpak uninstall --unused'
alias fup='flatpak update'
#alias aura="sudo aura"
export EDITOR=/bin/nano
export VISUAL=nano

#   set -l onedark_options '-b'
    #if set -q VIM
        # Using from vim/neovim.
     #   set onedark_options "-256"
    #else if string match -iq "eterm*" $TERM
     #   # Using from emacs.
    #    function fish_title; true; end
   #     set onedark_options "-256"
  #  end

 #   set_onedark $onedark_options
#end


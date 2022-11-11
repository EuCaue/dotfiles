#!/bin/fish

set f "$HOME/Pictures/Screenshots/$(date +'Screenshot from %Y-%m-%d %H-%M-%S.png')" && grim -g "$(slurp)" -c $f && wl-copy < $f
echo "print"

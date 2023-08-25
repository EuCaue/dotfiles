#!/usr/bin/env fish

set normal (tput sgr0)
set red (tput setaf 1)
set green (tput setaf 2)
set yellow (tput setaf 3)
set blue (tput setaf 4)
set magenta (tput setaf 5)
set cyan (tput setaf 6)
set white (tput setaf 7)


set distro_name (lsb_release -si)
set kernel (uname -r)
set uptime (uptime -p | sed -e 's/up //' -e 's/ day/ d/' -e 's/ hour/ h/' -e 's/ minute/ m/' -e 's/,//g' -e 's/ / /g' -e 's/h /h /' -e 's/m /m /')
set pkgs (sus -Qq | wc -l)
set wm (echo $XDG_CURRENT_DESKTOP)
set term (echo $TERM)
set cpu (lscpu | grep "Model name" | awk -F ': ' '{print $2}' | string trim)
set mem (free -b | awk '/^Mem:/ {used=$3/1024/1024/1024; total=$2/1024/1024/1024; printf "%.2fGiB / %.2fGiB\n", used, total}')
set font (echo $FONT_NAME)

function fetch
    echo "┌────────────┐ "
    echo "| $blue $distro_name"
    echo "| $normal $kernel"
    echo "| $white $uptime"
    echo "| $magenta $pkgs"
    echo "| $cyan $wm"
    echo "| $green $term"
    echo "| $yellow $cpu"
    echo "| $red $mem"
    echo "└────────────┘ "
end

fetch

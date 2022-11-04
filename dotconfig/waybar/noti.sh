#!/bin/fish

set statusD  $(/bin/swaync-client -D);
set count $(/bin/swaync-client -c); 
set normal  " ";
set not  " ";

if $statusD == true
    echo "$not $count"
else 
    echo "$normal $count"
end



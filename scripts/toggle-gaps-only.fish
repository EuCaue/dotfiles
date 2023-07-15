#!/usr/bin/env fish

set value $(hyprctl getoption master:no_gaps_when_only | grep -oP '(?<=int: )\S+')
hyprctl keyword master:no_gaps_when_only ( math 1 - $value )

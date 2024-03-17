#!/usr/bin/env fish
set markdown_folder $HOME/Documents/vault/
cd $markdown_folder

while true
    set selected_files $(fzf --preview 'bat --color=always {}' --pointer "->" --prompt "Select Files" --multi)
    echo $selected_files
    if test (count $selected_files) -eq 0
        return 1
    end
    nvim $selected_files
end

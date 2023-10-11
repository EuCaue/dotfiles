#!/usr/bin/env fish
set markdown_folder /home/caue/Documents/vault/

cd $markdown_folder

set -x FZF_DEFAULT_OPTS '
'

while true
    set selected_files $(fzf --preview 'bat --color=always --theme=base16 {}' --pointer "->" --prompt "Select Markdown " --margin 0,20,0,20 --multi)
    if test (count $selected_files) -eq 0
      return 1
    end

    nvim $selected_files
end

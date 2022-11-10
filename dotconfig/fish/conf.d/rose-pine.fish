# the syntax for this file: 
# set --local namewhatischange color # name of the color in the rose-pine palette

# if you have any suggestions, make a PR. 😃

# Color Palette
set --local foreground e0def4 # text
set --local selection 524f67 # highlight high
set --local selectionvi 524f67 # highlight high
set --local autosuggestions c4a7e7 # iris
set --local comment c4a7e7    # iris
set --local separators ebbcba # rose 
set --local errors eb6f92 # love 
set --local rootcolor eb6f92 # love 
set --local command 31748f # pine 
set --local cwduser 31748f # pine 
set --local escape f6c177 # gold
set --local remote f6c177 # gold
set --local quote f6c177 # gold
set --local description f6c177 # gold 
set --local param 9ccfd8 # foam 
set --local redirection ebbcba # rose
set --local progress 1f1d2e  # surface
set --local selection e0def4 # text
set --local prefix 9ccfd8 # foam
set --local secondary 191724  # base
set --local userprompt c4a7e7 # iris 
set --local host 524f67 # highlight high 
set --local keyword ebbcba # rose


# syntax highlighting variables
set --global fish_color_autosuggestion $autosuggestions # the color used for autosuggestions. (the proposed rest of a command)
set --global fish_color_cancel --reverse # the color for the '^c' indicator on a canceled command.
set --global fish_color_command $command # the color for commands.
set --global fish_color_comment $comment # the color used for code comments. (like '# important')
set --global fish_color_keyword $keyword # the color used for keywords like if - this falls back on command color if unset.
set --global fish_color_cwd $cwduser # the color used for the current working directory in the default prompt.
set --global fish_color_cwd_root $red # the color used for the current working directory when we're root.
set --global fish_color_end $separators # The color for process separators. (like ';' and '&')
set --global fish_color_error $errors # The color used to highlight potential errors.
set --global fish_color_escape $escape # The color used to highlight character escapes. (like '\n' and '\x70')
set --global fish_color_history_current --bold # The color used to print the current directory history (dirh).
set --global fish_color_host $host # The color used to print the hostname in the default prompt.
set --global fish_color_host_remote $remote # The color used to print the hostname in the default prompt for remote sessions. (like ssh)
set --global fish_color_match --background=$brblue # The color used to highlight matching parenthesis.
set --global fish_color_normal $foreground # The default color.
set --global fish_color_operator $command # The color for parameter expansion operators. (like '*' and '~')
set --global fish_color_param $param # The color for ordinary command parameters.
set --global fish_color_quote $quote # The color for quoted text. (like "abc")
set --global fish_color_redirection $redirection # The color for IO redirections. (like >/dev/null)
set --global fish_color_search_match --background=$selection # Used to highlight history search matches and the selected pager item (background only).
set --global fish_color_selection $selectionvi  --bold --background=$selectionvi # The color used when selecting text (in vi visual mode).
set --global fish_color_status $errors # The color used when stopped at a breakpoint.
set --global fish_color_user $userprompt # The color used for the username in the default prompt.
set --global fish_color_valid_path --underline # The color used for valid path.
set --global fish_pager_color_completion $foreground # The color of the completion itself, i.e. the proposed rest of the string.
set --global fish_pager_color_description $description --dim # The color of the completion description.
set --global fish_pager_color_prefix $prefix --bold # The color of the prefix string, i.e. the string that is to be completed.
set --global fish_pager_color_progress --background=$progress # The color of the progress bar at the bottom left corner.
set --global fish_pager_color_secondary $secondary # The background color of the every second completion.

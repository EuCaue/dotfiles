# Omni Theme - v1.0.0

# Color Palette
set --local background 191622
set --local foreground e1e1e6
set --local selection 41414d
set --local current 44475a
set --local comment 483c67
set --local orange ffb86c
set --local black 000000
set --local red ff5555
set --local green 50fa7b
set --local yellow effa78
set --local blue bd93f9
set --local purple ff79c6
set --local cyan 8d79ba
set --local white bfbfbf
set --local brblack 4d4d4d
set --local brred ff6e67
set --local brgreen 5af78e
set --local bryellow eaf08d
set --local brblue caa9fa
set --local brpurple ff92d0
set --local brcyan aa91e3
set --local brwhite e6e6e6

# Syntax highlighting variables
set --global fish_color_autosuggestion $comment # The color used for autosuggestions. (the proposed rest of a command)
set --global fish_color_cancel --reverse # The color for the '^C' indicator on a canceled command.
set --global fish_color_command $green # The color for commands.
set --global fish_color_comment $comment # The color used for code comments. (like '# important')
set --global fish_color_keyword $brpurple # The color used for keywords like if - this falls back on command color if unset.
set --global fish_color_cwd $green # The color used for the current working directory in the default prompt.
set --global fish_color_cwd_root $red # The color used for the current working directory when we're root.
set --global fish_color_end $orange # The color for process separators. (like ';' and '&')
set --global fish_color_error $red # The color used to highlight potential errors.
set --global fish_color_escape $yellow # The color used to highlight character escapes. (like '\n' and '\x70')
set --global fish_color_history_current --bold # The color used to print the current directory history (dirh).
set --global fish_color_host $foreground # The color used to print the hostname in the default prompt.
set --global fish_color_host_remote $yellow # The color used to print the hostname in the default prompt for remote sessions. (like ssh)
set --global fish_color_match --background=$brblue # The color used to highlight matching parenthesis.
set --global fish_color_normal $foreground # The default color.
set --global fish_color_operator $green # The color for parameter expansion operators. (like '*' and '~')
set --global fish_color_param $purple # The color for ordinary command parameters.
set --global fish_color_quote $yellow # The color for quoted text. (like "abc")
set --global fish_color_redirection $cyan # The color for IO redirections. (like >/dev/null)
set --global fish_color_search_match $bryellow --background=$selection # Used to highlight history search matches and the selected pager item (background only).
set --global fish_color_selection $white --bold --background=$selection # The color used when selecting text (in vi visual mode).
set --global fish_color_status $red # The color used when stopped at a breakpoint.
set --global fish_color_user $brgreen # The color used for the username in the default prompt.
set --global fish_color_valid_path --underline # The color used for valid path.
set --global fish_pager_color_completion $foreground # The color of the completion itself, i.e. the proposed rest of the string.
set --global fish_pager_color_description $yellow --dim # The color of the completion description.
set --global fish_pager_color_prefix $white --bold # The color of the prefix string, i.e. the string that is to be completed.
set --global fish_pager_color_progress $brwhite --background=$cyan # The color of the progress bar at the bottom left corner.
set --global fish_pager_color_secondary $brblack # The background color of the every second completion.

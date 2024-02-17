if status is-interactive
    starship init fish | source
    zoxide init fish | source
    set fish_greeting ""
    # BEST THING 
    echo -en '\e]22;ibeam\e\\'
    set --global fish_color_error brred --bold
    bind yy fish_clipboard_copy
    bind Y fish_clipboard_copy
    bind p fish_clipboard_paste
end

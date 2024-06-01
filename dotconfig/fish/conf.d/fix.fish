function set_mode_pre_execution --on-event fish_preexec
    set command (expr $argv : '\([^ ]*\).*')
    set -g __last_fish_bind_mode $fish_bind_mode
    if test $command = node
        or echo $command | grep python >/dev/null
    else
        set first_arg $(string split " " $argv)[1]
        if test $first_arg = v; or test $first_arg = nvim; and test -n "$TMUX"
            fish -c "tmux set-option -g mouse off"
        end
        echo -ne "\e[5 q" # block 
        printf '\e]50;CursorShape=1\x7'
    end
end
function set_mode_post_execution --on-event fish_postexec
    set temp $__last_fish_bind_mode
    set -e __last_fish_bind_mode
    set -g fish_bind_mode $temp
    fish_vi_cursor
    set first_arg $(string split " " $argv)[1]
    if test $first_arg = v; or test $first_arg = nvim; and test -n "$TMUX"
        fish -c "tmux set-option -g mouse on"
    end
end

function fish_vi_cursor --on-variable fish_bind_mode
    if set -q __last_fish_bind_mode
        and test $__last_fish_bind_mode = $fish_bind_mode
        return
    end
    set -g __last_fish_bind_mode $fish_bind_mode
    switch $fish_bind_mode
        case insert
            echo -ne "\e[5 q" # block 
            printf '\e]50;CursorShape=1\x7'
            printf "\033[2 q" # block
        case default
            echo -ne "\e[5 q" # block 
            printf '\e]50;CursorShape=1\x7'
            printf "\033[2 q" # block
        case "*"
            echo -ne "\e[5 q" # block 
            printf '\e]50;CursorShape=1\x7'
            printf "\033[2 q" # block
    end
end

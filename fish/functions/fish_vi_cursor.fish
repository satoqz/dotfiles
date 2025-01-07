function fish_vi_cursor --on-variable fish_bind_mode --on-event fish_postexec
    switch $fish_bind_mode
        case insert
            echo -en "\e[6 q" # line cursor
        case "*"
            echo -en "\e[2 q" # block cursor
    end
end

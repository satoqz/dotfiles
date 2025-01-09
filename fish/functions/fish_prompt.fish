function fish_prompt
    test -n "$SSH_TTY"; and printf "%s$USER@$hostname%s " \
        (set_color cyan) (set_color normal)

    printf "%s%s%s%s" \
        (set_color $fish_color_cwd) (fish_prompt_pwd_dir_length=0 prompt_pwd) \
        (set_color normal)

    printf "\n➜ "
end

function fish_prompt_newline --on-event fish_postexec
    echo
end

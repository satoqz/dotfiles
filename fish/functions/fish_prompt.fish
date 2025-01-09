function fish_prompt
    test -n "$SSH_TTY"; and printf "$USER@$hostname "
    printf "%s%s%s%s" (set_color cyan) (fish_prompt_pwd_dir_length=0 prompt_pwd) (set_color normal)
    printf "\n%s➜%s " (set_color green) (set_color normal)
end

function fish_prompt_newline --on-event fish_postexec
    echo
end

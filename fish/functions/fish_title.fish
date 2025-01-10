function fish_title
    test -n "$SSH_TTY"; and printf "$USER@$hostname "
    fish_prompt_pwd_dir_length=0 prompt_pwd
end

function fish_title
    set -q argv[1]; and echo "$argv "
    fish_prompt_pwd_dir_length=0 prompt_pwd
end

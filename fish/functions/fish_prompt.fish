function fish_prompt
    set -g __fish_git_prompt_showcolorhints 1
    set -g __fish_git_prompt_color_branch red
    printf "%s%s%s%s ➜ " \
        (set_color $fish_color_cwd) (fish_prompt_pwd_full_dirs=2 prompt_pwd) \
        (set_color normal) (fish_git_prompt)
end

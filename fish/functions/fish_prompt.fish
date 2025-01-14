set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_color_branch red
set -g __fish_git_prompt_shorten_branch_len 16

function fish_prompt
    echo -en "\e[6 q" # Resets cursor to line cursor.

    test -n "$SSH_TTY"; and printf "%s$USER@$hostname%s " \
        (set_color cyan) (set_color normal)

    printf "%s%s%s%s > " \
        (set_color $fish_color_cwd) (fish_prompt_pwd_dir_length=0 prompt_pwd) \
        (set_color normal) (fish_git_prompt)
end

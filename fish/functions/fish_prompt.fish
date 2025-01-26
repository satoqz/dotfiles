set -g __fish_git_prompt_char_stateseparator ""
set -g __fish_git_prompt_color_branch brred
set -g __fish_git_prompt_shorten_branch_len 16
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showupstream informative

function fish_prompt
    echo -en "\e[6 q" # Reset to bar cursor.

    test -n "$SSH_TTY" && printf "%s$USER@$hostname%s " \
        (set_color cyan) (set_color normal)

    printf "%s%s%s%s >> " \
        (set_color brgreen) (path basename (prompt_pwd)) \
        (set_color normal) (fish_git_prompt)
end

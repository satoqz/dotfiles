test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

set -gx GOPATH ~/.go

fish_add_path -m $GOPATH/bin
fish_add_path -m ~/.cargo/bin
fish_add_path -m ~/.local/bin

command -q hx && set -gx EDITOR hx

fish_vi_key_bindings

set -g fish_vi_force_cursor
set -g fish_cursor_default block
set -g fish_cursor_insert line
set -g fish_cursor_replace_one underscore
set -g fish_cursor_replace underscore
set -g fish_cursor_external block
set -g fish_cursor_visual block

function fish_title
    set -q argv[1] && echo $argv || echo fish
end

set -g __fish_git_prompt_char_stateseparator ""
set -g __fish_git_prompt_color_branch brred
set -g __fish_git_prompt_shorten_branch_len 16
set -g __fish_git_prompt_showcolorhints 1
set -g __fish_git_prompt_showdirtystate 1
set -g __fish_git_prompt_showupstream informative

function fish_prompt
    test -d /opt/orbstack-guest && printf "(orb) "
    printf "%s%s%s%s > " \
        (set_color brgreen) (path basename (prompt_pwd)) \
        (set_color normal) (fish_git_prompt)
end

functions -e fish_mode_prompt

function goto_repo
    set dir (fd \
        --base-directory "$HOME/src" --strip-cwd-prefix \
        --type directory --hidden '\.git$' --exec dirname \
        | sort | fzy)

    test -n "$dir" && cd "$HOME/src/$dir"
    commandline -f repaint
end

bind --mode insert \cr history-pager

command -q direnv && direnv hook fish | source
command -q eza && alias ls="eza -F --group-directories-first"
command -q fd && command -q fzy && bind --mode insert \cg goto_repo
command -q kubectl && alias k=kubectl
command -q kubecolor && alias k=kubecolor

set fish_greeting

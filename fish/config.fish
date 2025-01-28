if status is-login
    test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

    set -q EDITOR || set -gx EDITOR vim
    set -gx GOPATH ~/.go

    fish_add_path -m $GOPATH/bin
    fish_add_path -m ~/.cargo/bin
    fish_add_path -m ~/.local/bin
end

if status is-interactive
    fish_vi_key_bindings
    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_replace underscore
    set -g fish_cursor_external block
    set -g fish_cursor_visual block
    set -g fish_vi_force_cursor
    bind --mode insert \cr history-pager

    command -q direnv && direnv hook fish | source
    command -q eza && alias ls="eza -F -A"
    command -q fd && command -q fzy && bind --mode insert \cg goto_repo
    command -q kubectl && alias k=kubectl
    command -q kubecolor && alias k=kubecolor

    set -U fish_greeting
end


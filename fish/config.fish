if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

set -gx GOPATH ~/.go

fish_add_path -pm $GOPATH/bin
fish_add_path -pm ~/.cargo/bin
fish_add_path -pm ~/.local/bin

if status is-interactive
    set -U fish_greeting
    fish_vi_key_bindings
    bind --mode insert \cr history-pager

    command -v nvim >/dev/null; and alias vim=nvim; and set -gx EDITOR nvim
    command -v eza >/dev/null; and alias ls="eza -F -A"
    command -v kubectl >/dev/null; and alias k=kubectl
    command -v kubecolor >/dev/null; and alias k=kubecolor
    command -v direnv >/dev/null; and direnv hook fish | source
end

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

set -gx GOPATH ~/.go

fish_add_path -m $GOPATH/bin
fish_add_path -m ~/.cargo/bin
fish_add_path -m ~/.local/bin

fish_vi_key_bindings
bind --mode insert \cr history-pager

command -q eza; and alias ls="eza -F -A"
command -q kubectl; and alias k=kubectl
command -q kubecolor; and alias k=kubecolor
command -q direnv; and direnv hook fish | source

set -U fish_greeting

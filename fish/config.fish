test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

set -gx GOPATH ~/.go

fish_add_path -m $GOPATH/bin
fish_add_path -m ~/.cargo/bin
fish_add_path -m ~/.local/bin

command -q hx && not set -q EDITOR && set -gx EDITOR hx
command -q eza && alias ls="eza -F -A"
command -q kubectl && alias k=kubectl
command -q kubecolor && alias k=kubecolor
command -q direnv && direnv hook fish | source
command -q fd && command -q fzy && bind \cg goto_repo

set -U fish_greeting

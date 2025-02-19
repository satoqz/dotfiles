test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

set -gx GOPATH ~/.go

fish_add_path -m $GOPATH/bin
fish_add_path -m ~/.cargo/bin
fish_add_path -m ~/.local/bin

if not set -q EDITOR then
    command -q vim && set -gx EDITOR vim
    command -q hx && set -gx EDITOR hx
end

command -q direnv && direnv hook fish | source

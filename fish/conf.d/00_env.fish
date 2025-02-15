test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

set -gx GOPATH ~/.go

fish_add_path -m $GOPATH/bin
fish_add_path -m ~/.cargo/bin
fish_add_path -m ~/.local/bin

if set -q EDITOR then
    command -q vim && set -gx EDIOR vim
    command -q nvim && set -gx EDITOR nvim
end

command -q direnv && direnv hook fish | source

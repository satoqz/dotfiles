test -x /opt/homebrew/bin/brew && /opt/homebrew/bin/brew shellenv | source

set -gx GOPATH ~/.go

fish_add_path -m $GOPATH/bin
fish_add_path -m ~/.cargo/bin
fish_add_path -m ~/.local/bin

set editors vim hx nvim

if not set -q EDITOR
    for editor in $editors
        command -q $editor && set -gx EDITOR $editor
    end
end

command -q direnv && direnv hook fish | source

set -gx GOPATH ~/.go

if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv | source
end

fish_add_path ~/.go/bin
fish_add_path ~/.cargo/bin
fish_add_path ~/.local/bin

if status is-interactive
    command -v nvim >/dev/null; and set -gx EDITOR nvim; and alias vim=nvim
    command -v eza >/dev/null; and alias ls="eza -F -A"
    command -v kubectl >/dev/null; and alias k=kubectl
    command -v kubecolor >/dev/null; and alias k=kubecolor
    command -v direnv >/dev/null; and direnv hook fish | source

    fish_vi_key_bindings
    bind --mode insert \cr history-pager
    bind --mode insert \cf fzy_cd_git_repos

    set -U fish_greeting
end

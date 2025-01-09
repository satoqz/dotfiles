if status is-login
    if test -x /opt/homebrew/bin/brew
        /opt/homebrew/bin/brew shellenv | source
    end

    set -gx GOPATH ~/.go

    fish_add_path $GOPATH/bin
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.local/bin
end

if status is-interactive
    set -U fish_greeting

    set fish_color_command green
    set fish_color_param white
    set fish_color_comment brblack

    fish_vi_key_bindings
    bind --mode insert \cr history-pager

    command -v eza >/dev/null; and alias ls="eza -F -A"
    command -v kubectl >/dev/null; and alias k=kubectl
    command -v kubecolor >/dev/null; and alias k=kubecolor
    command -v direnv >/dev/null; and direnv hook fish | source
end

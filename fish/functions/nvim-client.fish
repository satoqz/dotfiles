function nvim-client -d "Attach to a headless Neovim server"
    if test (count $argv) != 1
        echo "Usage: $(status current-function) <session name>"
        return 1
    end

    set sessions_dir "$HOME/.cache/nvim/sessions"
    nvim --remote-ui --server "$sessions_dir/$argv.pipe"
end

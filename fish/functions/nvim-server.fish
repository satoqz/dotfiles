function nvim-server -d "Start a headless Neovim session"
    if test (count $argv) != 1
        echo "Usage: $(status current-function) [session name] [--list]"
        return 1
    end

    set sessions_dir "$HOME/.cache/nvim/sessions"
    mkdir -p "$sessions_dir"

    if test $argv = --list
        for pipe in $sessions_dir/*.pipe
            echo (string trim --right --chars .pipe (string trim --left --chars "$sessions_dir" "$pipe"))
        end
        return 0
    end

    nvim --headless --listen "$sessions_dir/$argv.pipe" &
    disown
end

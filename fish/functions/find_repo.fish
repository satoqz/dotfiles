function find_repo
    set dir (fd \
        --base-directory "$HOME/src" --strip-cwd-prefix \
        --type directory --hidden '\.git$' --exec dirname \
        | sort | fzy)

    if test -n "$dir"
        cd "$HOME/src/$dir"
    end

    commandline -f repaint
end

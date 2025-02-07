function goto-repo
    set dir (fd \
        --base-directory "$HOME/src" --strip-cwd-prefix \
        --type directory --hidden '\.git$' --exec dirname \
        | sort | fzy)

    test -n "$dir" && cd "$HOME/src/$dir"
    commandline -f repaint
end

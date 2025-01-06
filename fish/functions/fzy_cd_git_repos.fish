function fzy_cd_git_repos
    cd ~/src/(fd --base-directory ~/src --strip-cwd-prefix --type directory --hidden '\.git$' --exec dirname | sort | fzy)
    commandline -f repaint
end

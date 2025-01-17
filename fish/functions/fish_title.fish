function fish_title
    set -q argv[1] && echo $argv || echo fish
end

function fish_title
    set -q argv[1] || set argv fish
    echo $argv
end

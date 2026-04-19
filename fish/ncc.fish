function ncc --description "cargo compete new <contest> && cd <contest> && nvim ."
    if test (count $argv) -ne 1
        echo "usage: ncc <contest-name>"
        return 1
    end

    set -l contest $argv[1]
    cargo compete new $contest; or return $status
    cd $contest; and nvim .
end

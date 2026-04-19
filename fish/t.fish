function t --description "cargo compete test <problem-id>"
    if test (count $argv) -ne 1
        echo "usage: t <problem-id>"
        return 1
    end

    set -l id $argv[1]
    cargo compete test $id
end

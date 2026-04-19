function s --description "cargo compete submit <problem-id>"
    if test (count $argv) -ne 1
        echo "usage: s <problem-id>"
        return 1
    end

    set -l id $argv[1]
    cargo compete submit $id
end

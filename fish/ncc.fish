function ncc --description "cargo compete new <contest> && cd <contest> && nvim ."
    if test (count $argv) -ne 1
        echo "usage: ncc <contest-name>"
        return 1
    end

    set -l contest $argv[1]

    if test -e "$contest"
        if not test -d "$contest"
            echo "error: '$contest' exists and is not a directory."
            return 1
        end

        while true
            read -l -P "Directory '$contest' already exists. Delete and recreate? [y/N]: " answer
            set -l answer_normalized (string lower -- (string trim -- "$answer"))

            switch "$answer_normalized"
                case y yes
                    rm -rf -- "$contest"
                    break
                case '' n no
                    echo "canceled."
                    return 1
                case '*'
                    echo "please answer y or n."
            end
        end
    end

    cargo compete new $contest; or return $status
    cd $contest; and nvim .
end

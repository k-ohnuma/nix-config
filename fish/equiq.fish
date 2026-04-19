function eq --description "cargo equip for library checker"
    set -l bin_flag
    if test (count $argv) -gt 0
        set bin_flag --bin $argv[1]
    end

    cargo equip --remove docs --remove comments --minify libs --no-check $bin_flag > submit.rs
end

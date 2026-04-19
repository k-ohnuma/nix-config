function eqq --description "cargo equip for atcoder"
    set -l bin_flag
    if test (count $argv) -gt 0
        set bin_flag --bin $argv[1]
    end

    cargo equip \
        --exclude ac-library-rs \
        --exclude itertools \
        --exclude num \
        --exclude num-bigint \
        --exclude num-decimal \
        --exclude proconio \
        --exclude rust-decimal \
        --exclude superslice \
        --exclude regex \
        --exclude num-traits \
        --exclude easy-ext \
        --remove docs \
        --remove comments \
        --minify libs \
        --no-check \
        $bin_flag > submit.rs
end

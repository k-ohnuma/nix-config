{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Nix editing and formatting.
    nixd
    nixfmt

    # Core CLI utilities used across repos.
    awscli2
    bat
    curl
    direnv
    eza
    fd
    fzf
    httpie
    jq
    just
    nb
    ripgrep
    taplo
    tree
    wget
    yamlfmt
    yamllint
    stylua
    yq
    zoxide
    biome
    uv
    python3
    nodejs_24

    # GNU userland replacements and extended shell tools.
    coreutils
    gawk
    findutils
    gnugrep
    gnused
    gnumake
    parallel
    time

    # Build and task execution tools.
    cargo-make
    cmake
    lua
    luarocks
    ninja
    pkg-config

    # Document and image processing utilities.
    ghostscript
    imagemagick
    pngpaste
    tectonic
  ];
}

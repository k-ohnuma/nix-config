{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Nix editing and formatting.
    nixd
    nixfmt-rfc-style

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
    mise
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
    gcc
    ninja
    pkg-config

    # Document and image processing utilities.
    ghostscript
    imagemagick
    pngpaste
    tectonic
  ];
}

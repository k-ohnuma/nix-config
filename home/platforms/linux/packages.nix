{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Required by Neovim plugins such as nvim-treesitter when parsers are built locally.
    gcc
  ];
}

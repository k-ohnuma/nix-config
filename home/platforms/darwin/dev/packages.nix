{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # macOS clipboard image utility.
    pngpaste
  ];
}

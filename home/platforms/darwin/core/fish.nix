{ lib, libx, ... }:
{
  xdg.configFile."fish/functions/copyimage.fish".source = libx.relativeToRoot "fish/copyimage.fish";

  programs.fish.interactiveShellInit = lib.mkBefore ''
    if test -x /opt/homebrew/bin/brew
      eval "$(/opt/homebrew/bin/brew shellenv)"
    end
  '';
}

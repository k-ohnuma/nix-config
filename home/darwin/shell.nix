{ lib, ... }:
{
  programs.fish.interactiveShellInit = lib.mkBefore ''
    if test -x /opt/homebrew/bin/brew
      eval "$(/opt/homebrew/bin/brew shellenv)"
    end
  '';

  programs.zsh.initContent = lib.mkBefore ''
    if [[ -x /opt/homebrew/bin/brew ]]; then
      eval "$(/opt/homebrew/bin/brew shellenv zsh)"
    fi
  '';
}

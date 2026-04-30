{ ... }:
{
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}

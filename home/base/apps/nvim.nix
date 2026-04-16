{ config, nixConfigRelativePath ? "nix/nix-config", ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${nixConfigRelativePath}/nvim";
}

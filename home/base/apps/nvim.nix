{
  config,
  inputs,
  system,
  nixConfigRelativePath,
  ...
}:
let
  neovimPkgs = import inputs.nixpkgs-neovim {
    inherit system;
    config.allowUnfree = true;
  };
in
{
  programs.neovim = {
    enable = true;
    package = neovimPkgs.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${nixConfigRelativePath}/nvim";
}

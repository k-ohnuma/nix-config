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
    withRuby = false;
    withPython3 = false;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    sideloadInitLua = true;
  };

  xdg.configFile."nvim".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/${nixConfigRelativePath}/nvim";
}

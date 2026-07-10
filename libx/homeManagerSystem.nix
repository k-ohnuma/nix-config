{
  inputs,
  libx,
  home-modules,
  system,
  hostName,
  userName,
  nixConfigRelativePath,
  vars,
  specialArgs ? {
    inherit
      inputs
      libx
      hostName
      userName
      system
      nixConfigRelativePath
      vars
      ;
  },
  ...
}:
let
  inherit (inputs) nixpkgs home-manager;

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  modules = home-modules;
  extraSpecialArgs = specialArgs;
}

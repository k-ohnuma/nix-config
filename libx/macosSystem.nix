{
  lib,
  libx,
  inputs,
  darwin-modules,
  home-modules ? [ ],
  system,
  hostName,
  userName,
  nixConfigRelativePath,
  specialArgs ? {
    inherit
      inputs
      libx
      hostName
      userName
      system
      nixConfigRelativePath
      ;
  },
  ...
}:
let
  inherit (inputs) nixpkgs-darwin home-manager nix-darwin;
in
nix-darwin.lib.darwinSystem {
  inherit system specialArgs;
  modules =
    darwin-modules
    ++ [
      (
        { ... }:
        {
          nixpkgs.pkgs = import nixpkgs-darwin {
            inherit system;
            config.allowUnfree = true;
          };
        }
      )
    ]
    ++ (lib.optionals ((lib.lists.length home-modules) > 0) [
      home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = false;
        home-manager.backupFileExtension = "home-manager.backup";

        home-manager.extraSpecialArgs = specialArgs;
        home-manager.users."${userName}".imports = home-modules;
      }
    ]);
}

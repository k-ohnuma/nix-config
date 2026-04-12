{
  lib,
  inputs,
  darwin-modules,
  home-modules ? [ ],
  system,
  userName,
  ...
}:
let
  inherit (inputs) nixpkgs-darwin home-manager nix-darwin;
in
nix-darwin.lib.darwinSystem {
  inherit system;
  modules =
    darwin-modules
    ++ [
      (
        { lib, ... }:
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
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "home-manager.backup";

        home-manager.users."${userName}".imports = home-modules;
      }
    ]);
}

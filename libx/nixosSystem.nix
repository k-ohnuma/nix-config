{
  lib,
  libx,
  inputs,
  nixos-modules,
  home-modules ? [ ],
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
  inherit (inputs) nixpkgs home-manager nixos-wsl;
in
nixpkgs.lib.nixosSystem {
  inherit system specialArgs;
  modules = [
    nixos-wsl.nixosModules.default
    {
      nixpkgs.config.allowUnfree = true;
    }
  ]
  ++ nixos-modules
  ++ (lib.optionals ((lib.lists.length home-modules) > 0) [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = false;
      home-manager.backupFileExtension = "home-manager.backup";

      home-manager.extraSpecialArgs = specialArgs;
      home-manager.users."${userName}".imports = home-modules;
    }
  ]);
}

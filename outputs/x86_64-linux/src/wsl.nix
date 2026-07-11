{
  inputs,
  lib,
  libx,
  system,
  vars,
  ...
}@args:
let
  hostName = "user";
  userName = "user";
  nixConfigRelativePath = "nix/nix-config";

  modules = {
    nixos-modules = map libx.relativeToRoot [
      "modules/nixos"
    ];
    home-modules = map libx.relativeToRoot [
      "home/hosts/wsl/${userName}.nix"
    ];
  };

  systemArgs =
    modules
    // args
    // {
      inherit
        hostName
        inputs
        lib
        libx
        system
        userName
        nixConfigRelativePath
        vars
        ;
    };
in
{
  nixosConfigurations.${hostName} = libx.nixosSystem systemArgs;
}

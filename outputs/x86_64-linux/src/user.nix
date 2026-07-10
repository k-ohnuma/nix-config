{
  inputs,
  lib,
  libx,
  system,
  vars,
  ...
}@args:
let
  hostName = "wsl";
  userName = "user";
  nixConfigRelativePath = "nix/nix-config";

  modules = {
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
  homeConfigurations.${userName} = libx.homeManagerSystem systemArgs;
}

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
    darwin-modules = map libx.relativeToRoot [
      "modules/darwin"
    ];
    home-modules = map libx.relativeToRoot [
      "home/hosts/darwin/${hostName}.nix"
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
  darwinConfigurations.${hostName} = libx.macosSystem systemArgs;
}

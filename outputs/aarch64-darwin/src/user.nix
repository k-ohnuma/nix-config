{
  inputs,
  lib,
  libx,
  system,
  ...
}@args:
let
  hostName = "user";
  userName = "user";
  nixConfigRelativePath = "nix/nix-config";

  modules = {
    darwin-modules = [
      {
        users.users.${userName}.home = "/Users/${userName}";
        system.primaryUser = userName;
        system.stateVersion = 6;
        nix.enable = false;
      }
    ];
    home-modules = map libx.relativeToRoot [
      "home/hosts/darwin/${hostName}.nix"
    ];
  };

  systemArgs = modules // args // {
    inherit
      hostName
      inputs
      lib
      libx
      system
      userName
      nixConfigRelativePath
      ;
  };
in
{
  darwinConfigurations.${hostName} = libx.macosSystem systemArgs;
}

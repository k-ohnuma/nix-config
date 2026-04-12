{ libx, ... }@args:
let
  hostName = "user";
  userName = "user";

  modules = {
    darwin-modules = [ ];
    home-modules = map libx.relativeToRoot [
      "home/hosts/darwin/${hostName}.nix"
    ];
  };

  systemArgs = modules // args // { inherit hostName userName; };
in
{
  darwinConfigurations.${hostName} = libx.macosSystem systemArgs;
}

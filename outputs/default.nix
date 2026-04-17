{ nixpkgs, ... }@inputs:
let
  inherit (nixpkgs) lib;
  libx = import ../libx { inherit lib; };
  args = { inherit inputs libx lib; };
  darwinSystems = {
    aarch64-darwin = import ./aarch64-darwin (args // { system = "aarch64-darwin"; });
  };
  darwinSystemValues = builtins.attrValues darwinSystems;
in
{
  darwinConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.darwinConfigurations or { }) darwinSystemValues
  );

  evalTests = lib.lists.all (it: it.evalTests == { }) darwinSystemValues;
}

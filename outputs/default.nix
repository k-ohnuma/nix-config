{ nixpkgs, ... }@inputs:
let
  inherit (nixpkgs) lib;
  libx = import ../libx { inherit lib; };
  vars = inputs.vars.lib;
  args = {
    inherit
      inputs
      libx
      lib
      vars
      ;
  };
  darwinSystems = {
    aarch64-darwin = import ./aarch64-darwin (args // { system = "aarch64-darwin"; });
  };
  allSystems = darwinSystems;
  allSystemNames = builtins.attrNames allSystems;
  forAllSystems = func: lib.genAttrs allSystemNames func;
  darwinSystemValues = builtins.attrValues darwinSystems;
in
{
  darwinConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.darwinConfigurations or { }) darwinSystemValues
  );

  evalTests = lib.lists.all (it: it.evalTests == { }) darwinSystemValues;

  devShells = forAllSystems (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      default = pkgs.mkShell {
        name = "nix-config";
        packages = with pkgs; [
          git
          just
          nixfmt
        ];
      };
    }
  );
}

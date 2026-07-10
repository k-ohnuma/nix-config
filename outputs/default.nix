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
  linuxSystems = {
    x86_64-linux = import ./x86_64-linux (args // { system = "x86_64-linux"; });
  };
  allSystems = darwinSystems // linuxSystems;
  allSystemNames = builtins.attrNames allSystems;
  forAllSystems = func: lib.genAttrs allSystemNames func;
  darwinSystemValues = builtins.attrValues darwinSystems;
  allSystemValues = builtins.attrValues allSystems;
in
{
  darwinConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.darwinConfigurations or { }) darwinSystemValues
  );

  homeConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.homeConfigurations or { }) allSystemValues
  );

  evalTests = lib.lists.all (it: it.evalTests == { }) allSystemValues;

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

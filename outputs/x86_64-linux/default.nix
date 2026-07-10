{
  lib,
  inputs,
  ...
}@args:
let
  inherit (inputs) haumea;

  data = haumea.lib.load {
    src = ./src;
    inputs = args;
  };
  dataWithoutPaths = builtins.attrValues data;
in
{
  inherit data;

  homeConfigurations = lib.attrsets.mergeAttrsList (
    map (it: it.homeConfigurations or { }) dataWithoutPaths
  );

  evalTests = { };
}

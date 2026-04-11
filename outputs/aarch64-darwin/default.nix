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

  outputs = {
    darwinConfigurations = lib.attrsets.mergeAttrsList (
      map (it: it.darwinConfigurations or { }) dataWithoutPaths
    );
  };
in
outputs
// {
  inherit data; 
}

{
  lib,
  outputs,
  ...
}:
let
  hosts = builtins.attrNames outputs.darwinConfigurations;
in
lib.genAttrs hosts (_: {
  cmdSpaceEnabled = false;
  cmdAltSpaceEnabled = false;
  naturalScroll = false;
})

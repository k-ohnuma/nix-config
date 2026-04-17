{
  lib,
  outputs,
  ...
}:
let
  hosts = builtins.attrNames outputs.darwinConfigurations;
in
lib.genAttrs hosts (_: {
  rotate = false;
  pinch = true;
  smartZoom = true;
  threeFingerDrag = true;
  momentumScroll = true;
})

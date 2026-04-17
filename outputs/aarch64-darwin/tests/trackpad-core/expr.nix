{
  lib,
  outputs,
  ...
}:
let
  hosts = builtins.attrNames outputs.darwinConfigurations;
in
lib.genAttrs hosts (
  name:
  let
    trackpad = outputs.darwinConfigurations.${name}.config.system.defaults.trackpad;
  in
  {
    rotate = trackpad.TrackpadRotate;
    pinch = trackpad.TrackpadPinch;
    smartZoom = trackpad.TrackpadTwoFingerDoubleTapGesture;
    threeFingerDrag = trackpad.TrackpadThreeFingerDrag;
    momentumScroll = trackpad.TrackpadMomentumScroll;
  }
)

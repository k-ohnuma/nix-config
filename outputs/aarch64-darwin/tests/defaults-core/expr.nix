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
    cfg = outputs.darwinConfigurations.${name}.config;
  in
  {
    cmdSpaceEnabled =
      cfg.system.defaults.CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys."64".enabled;
    cmdAltSpaceEnabled =
      cfg.system.defaults.CustomUserPreferences."com.apple.symbolichotkeys".AppleSymbolicHotKeys."65".enabled;
    naturalScroll = cfg.system.defaults.NSGlobalDomain."com.apple.swipescrolldirection";
  }
)

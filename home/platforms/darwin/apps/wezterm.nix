{ lib, libx, ... }:
{
  programs.wezterm.extraConfig = lib.mkForce (
    builtins.readFile (libx.relativeToRoot "wezterm/wezterm.lua")
  );
  xdg.configFile."wezterm/darwin.lua".source = libx.relativeToRoot "wezterm/darwin.lua";
}

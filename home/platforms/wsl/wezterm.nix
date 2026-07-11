{ libx, ... }:
{
  xdg.configFile = {
    "wezterm/common.lua".source = libx.relativeToRoot "wezterm/common.lua";
    "wezterm/windows.lua".source = libx.relativeToRoot "wezterm/windows.lua";
  };
}

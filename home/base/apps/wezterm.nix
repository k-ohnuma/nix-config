{ libx, ... }:
{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile (libx.relativeToRoot "wezterm/wezterm.lua");
  };
  xdg.configFile."wezterm/stylua.toml".source = libx.relativeToRoot "wezterm/stylua.toml";
}

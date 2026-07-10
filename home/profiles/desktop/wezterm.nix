{ libx, ... }:
{
  programs.wezterm = {
    enable = true;
    # これ明示しないとprecmdでshell遅くなる
    enableZshIntegration = false;
    extraConfig = builtins.readFile (libx.relativeToRoot "wezterm/common.lua");
  };
  xdg.configFile = {
    "wezterm/common.lua".source = libx.relativeToRoot "wezterm/common.lua";
    "wezterm/stylua.toml".source = libx.relativeToRoot "wezterm/stylua.toml";
  };
}

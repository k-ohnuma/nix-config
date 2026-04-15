{ libx, ... }:
{
  programs.wezterm = {
    enable = true;
    # これ明示しないとprecmdでshell遅くなる
    enableZshIntegration = false;
    extraConfig = builtins.readFile (libx.relativeToRoot "wezterm/wezterm.lua");
  };
  xdg.configFile."wezterm/stylua.toml".source = libx.relativeToRoot "wezterm/stylua.toml";
}

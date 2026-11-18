{ pkgs, ... }:
{
  programs.ghostty = {
    enable = true;
    # これ明示しないとprecmdでshell遅くなる
    enableZshIntegration = false;
    package =
      if pkgs.stdenv.isDarwin then
        (if pkgs ? ghostty-bin then pkgs.ghostty-bin else null)
      else
        pkgs.ghostty;
    settings = {
      font-family = "Bizin Gothic NF";
      font-size = 15;
      theme = "Ayu Mirage";

      cursor-style = "block";
      cursor-color = "f0fcff";
      cursor-style-blink = false;
      shell-integration-features = "no-cursor";

      window-show-tab-bar = "never";
      background-opacity = 1.0;
      quick-terminal-position = "center";
      quick-terminal-screen = "main";
      quick-terminal-animation-duration = 0.3;

      keybind = [
        "ctrl+n>-=new_split:down"
        "ctrl+n>alt+\\=new_split:right"
        "ctrl+n>l=goto_split:right"
        "ctrl+n>k=goto_split:up"
        "ctrl+n>j=goto_split:down"
        "ctrl+n>h=goto_split:left"
        "global:ctrl+shift+tab=toggle_quick_terminal"
      ];
    };
  };
}

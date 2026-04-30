{ config, ... }:
{
  programs.kitty = {
    enable = true;

    font = {
      name = "Bizin Gothic NF";
      size = 15;
    };

    themeFile = "ayu_mirage";

    settings = {
      shell = "${config.home.homeDirectory}/.nix-profile/bin/fish";
      cursor_shape = "block";
      cursor = "#f0fcff";
      cursor_blink_interval = 0;

      shell_integration = "no-cursor";

      tab_bar_min_tabs = 1;
      tab_bar_edge = "top";

      background_opacity = "0.9";

      enabled_layouts = "splits";

      hide_window_decorations = "titlebar-only";
    };

    keybindings = {
      "cmd+u" = "next_tab";
      "cmd+y" = "previous_tab";

      "ctrl+b>-" = "launch --location=hsplit";
      "ctrl+b>0x5d" = "launch --location=vsplit";
      "ctrl+b>alt+0x5d" = "launch --location=vsplit";

      "alt+l" = "neighboring_window right";
      "alt+k" = "neighboring_window up";
      "alt+j" = "neighboring_window down";
      "alt+h" = "neighboring_window left";
    };
  };
}

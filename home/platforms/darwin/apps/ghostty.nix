{ lib, ... }:
{
  programs.ghostty = {
    settings = {
      macos-titlebar-style = "tabs";
      macos-window-buttons = "hidden";
      macos-option-as-alt = false;
      keybind = lib.mkAfter [
        "cmd+u=next_tab"
        "cmd+y=previous_tab"
      ];
    };
  };
}

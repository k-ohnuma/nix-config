{ lib, ... }:
{
  programs.ghostty = {
    settings = {
      macos-titlebar-style = "tabs";
      macos-window-buttons = "hidden";
      macos-option-as-alt = false;
      keybind = lib.mkAfter [
        # Option+h/j/k/l を Alt キー列として Herdr に送る
        "alt+h=text:\\x1bh"
        "alt+j=text:\\x1bj"
        "alt+k=text:\\x1bk"
        "alt+l=text:\\x1bl"
        "cmd+u=next_tab"
        "cmd+y=previous_tab"
      ];
    };
  };
}

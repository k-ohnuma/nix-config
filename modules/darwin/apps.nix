{ ... }:
{
  # homebrew need to be installed manually, see https://brew.sh
  # https://github.com/LnL7/nix-darwin/blob/master/modules/homebrew.nix
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # nixで管理してないパッケージをuninstall
      cleanup = "uninstall";
    };

    # brew install
    brews = [
      # これらをnixでinstallするとcc関連で怒られた
      "libgit2"
      "openssl@3"
    ];

    # brew install --cask
    # ghostty, weztermはhmで引っ張る
    casks = [
      # Browsers
      "firefox"
      "google-chrome"

      # Communication
      "slack"
      "zoom"

      # Desktop tools
      "hiddenbar"
      "karabiner-elements"
      "raycast"
      "rectangle"

      # Security
      "keepassxc"

      # Development
      "burp-suite"
      "docker-desktop"
      "httpie-desktop"
      "zap"
    ];
  };
}

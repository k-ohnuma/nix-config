{
  lib,
  userName,
  ...
}:
{
  time.timeZone = "Asia/Tokyo";
  system = {
    activationScripts.postActivation.text = lib.mkAfter ''
      # macOS の設定変更をログアウトなしで即時反映する
      /usr/bin/sudo -u ${userName} /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;
      dock = {
        # Dock のアイコンサイズ
        tilesize = 50;
        # Dock を自動的に表示・非表示
        autohide = true;
        # アプリ起動時のアニメーション
        launchanim = true;
        # 起動中アプリのインジケーター（ドット）を表示
        show-process-indicators = true;
        # 最近使ったアプリを Dock に表示しない
        show-recents = false;
      };

      finder = {
        # タイトルバーにフルパス表示
        _FXShowPosixPathInTitle = true;
        # 拡張子を表示
        AppleShowAllExtensions = true;
        # 拡張子変更の警告
        FXEnableExtensionChangeWarning = false;
        # finderの終了ができるように
        QuitMenuItem = true;
        # パスバーの有効か
        ShowPathbar = true;
        # ステータスバーの有効化
        ShowStatusBar = true;
      };
      CustomUserPreferences = {
        "com.apple.symbolichotkeys" = {
          AppleSymbolicHotKeys = {
            # Spotlight検索を無効化
            "64" = {
              enabled = false;
            };
            # Finder 検索ウィンドウを無効化
            "65" = {
              enabled = false;
            };
          };
        };
      };
    };
  };
}

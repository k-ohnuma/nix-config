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
      NSGlobalDomain = {
        # 拡張子を常に表示
        AppleShowAllExtensions = true;
        # ナチュラルスクロール
        "com.apple.swipescrolldirection" = false;
        # 音量変更時の音
        "com.apple.sound.beep.feedback" = 0;
        # ダークモード
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        # キー長押し時のアクセント入力を有効化
        ApplePressAndHoldEnabled = false;

        # キーリピート開始までの待ち時間
        # 最小15(225ms) / 最大120(1800ms)
        InitialKeyRepeat = 15;
        # キーリピート速度（小さいほど速い）
        # 最小2(30ms) / 最大120(1800ms)
        KeyRepeat = 2;

        # 入力補助の自動置換系を無効化
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
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

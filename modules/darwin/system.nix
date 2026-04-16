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
        # 起動中アプリのインジケーターを表示
        show-process-indicators = true;
        # 最近使ったアプリを Dock に表示しない
        show-recents = false;
        # 4本指スプレッドでデスクトップ表示
        showDesktopGestureEnabled = true;
        # 4本指上下スワイプで Mission Control
        showMissionControlGestureEnabled = true;
        # App Exposé ジェスチャーは無効
        showAppExposeGestureEnabled = false;
        # Launchpad ジェスチャーは無効
        showLaunchpadGestureEnabled = false;
      };

      trackpad = {
        # タップでクリック
        Clicking = true;
        # 2本指で右クリック
        TrackpadRightClick = true;
        TrackpadCornerSecondaryClick = 0;

        # 調べる＆データ検出: 1本指で強めのクリック
        ForceSuppressed = false;
        ActuateDetents = true;
        # 3本指タップでの調べるは無効
        TrackpadThreeFingerTapGesture = 0;

        # 静音クリックを有効（0: 有効, 1: 無効）
        ActuationStrength = 0;
        FirstClickThreshold = 2;
        SecondClickThreshold = 2;

        # 拡大縮小 / スマートズーム / 回転
        TrackpadPinch = true;
        TrackpadTwoFingerDoubleTapGesture = true;
        TrackpadRotate = false;

        # ページ間スワイプは無効、フルスクリーン切替は4本指横スワイプ
        TrackpadThreeFingerHorizSwipeGesture = 0;
        TrackpadFourFingerHorizSwipeGesture = 2;

        # Mission Control を4本指縦スワイプに割り当て
        TrackpadThreeFingerVertSwipeGesture = 0;
        TrackpadFourFingerVertSwipeGesture = 2;

        # 慣性スクロール有効
        TrackpadMomentumScroll = true;

        # ドラッグを有効（3本指ドラッグ）
        Dragging = false;
        TrackpadThreeFingerDrag = true;
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
        # ページ間スワイプを無効化
        AppleEnableSwipeNavigateWithScrolls = false;
        # 音量変更時の音
        "com.apple.sound.beep.feedback" = 0;
        # ダークモード
        AppleInterfaceStyle = "Dark";
        AppleKeyboardUIMode = 3;
        # キー長押し時のアクセント入力を有効化
        ApplePressAndHoldEnabled = false;
        # 調べる＆データ検出（1本指強めクリック）を有効化
        "com.apple.trackpad.forceClick" = true;
        "com.apple.trackpad.scaling" = 0.6875;

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
        "com.apple.AppleMultitouchTrackpad" = {
          # スクロールにトラックパッドを使用
          TrackpadScroll = 1;
        };
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
        ".GlobalPreferences" = {
          # automatically switch to a new space when switching to the application
          AppleSpacesSwitchOnActivate = true;
        };
        "com.apple.finder" = {
          AppleShowAllFiles = true;
          ShowExternalHardDrivesOnDesktop = false;
          ShowHardDrivesOnDesktop = false;
          ShowMountedServersOnDesktop = false;
          ShowRemovableMediaOnDesktop = false;
          _FXSortFoldersFirst = false;
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
        "com.apple.screencapture" = {
          location = "~/Desktop/ss";
          type = "png";
        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };

        loginwindow = {
          GuestEnabled = false;
          SHOWFULLNAME = false;
        };
      };
    };
  };
}

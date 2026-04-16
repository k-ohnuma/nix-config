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
        tilesize = 50;
        autohide = true;
        launchanim = true;
        show-process-indicators = true;
        show-recents = false;
      };
    };
  };
}

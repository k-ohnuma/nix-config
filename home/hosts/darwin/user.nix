{ libx, ... }:
{
  imports = [ ../../darwin ];
  # WIP: ここでこのホスト固有設定が欲しくなったら書く。とりあえずはdarwin共通設定
  home.file.".npmrc".source = libx.relativeToRoot "npm/.npmrc";
}

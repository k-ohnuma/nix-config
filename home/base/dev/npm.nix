{ libx, ... }:
{
  xdg.configFile."pnpm/rc".source = libx.relativeToRoot "npm/.pnpmrc";
  home.file.".npmrc".source = libx.relativeToRoot "npm/.npmrc";
}

{ libx, ... }:
{
  xdg.configFile."pnpm/rc".source = libx.relativeToRoot "npm/.pnpmrc";
}

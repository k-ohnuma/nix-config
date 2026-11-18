{ libx, ... }:
{
  xdg.configFile."herdr/config.toml".source = libx.relativeToRoot "herdr/config.toml";
}

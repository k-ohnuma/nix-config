{ libx, ... }:
{
  xdg.configFile."karabiner/karabiner.json".source = libx.relativeToRoot "karabiner/karabiner.json";
}

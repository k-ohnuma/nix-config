{ libx, ... }:
{
  xdg.configFile."fish/functions/copyimage.fish".source = libx.relativeToRoot "fish/copyimage.fish";
}

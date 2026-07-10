{ libx, ... }:
{
  imports = [ ../../platforms/darwin ];
  home.file.".npmrc".source = libx.relativeToRoot "npm/.npmrc";
}

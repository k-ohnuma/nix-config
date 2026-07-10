{
  libx,
  userName,
  ...
}:
{
  home.homeDirectory = "/Users/${userName}";
  imports = (libx.scanPaths ./.) ++ [
    ../base/home.nix
    ../base/core
    ../base/dev
    ../base/apps
    ../profiles/desktop
  ];
  xdg.enable = true;
}

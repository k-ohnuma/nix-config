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
  ];
  xdg.enable = true;
}

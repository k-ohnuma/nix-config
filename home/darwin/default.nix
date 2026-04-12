{
  libx,
  ...
}:
{
  imports = (libx.scanPaths ./.) ++ [
    ../base/home.nix
  ];

  # enable management of XDG base directories on macOS.
  xdg.enable = true;
}


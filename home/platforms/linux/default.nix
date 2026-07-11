{
  userName,
  ...
}:
{
  home.homeDirectory = "/home/${userName}";
  imports = [
    ../../base
    ./packages.nix
  ];
  xdg.enable = true;
}

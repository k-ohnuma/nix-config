{
  userName,
  ...
}:
{
  home.homeDirectory = "/Users/${userName}";
  imports = [
    ../../base
    ../../profiles/desktop
    ./core
    ./dev
    ./apps
  ];
  xdg.enable = true;
}

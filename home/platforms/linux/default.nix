{
  userName,
  ...
}:
{
  home.homeDirectory = "/home/${userName}";
  imports = [
    ../../base
  ];
  xdg.enable = true;
}

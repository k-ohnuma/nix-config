{
  hostName,
  pkgs,
  userName,
  ...
}:
{
  wsl = {
    enable = true;
    defaultUser = userName;
  };

  networking.hostName = hostName;

  users.users.${userName} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  system.stateVersion = "26.05";
}

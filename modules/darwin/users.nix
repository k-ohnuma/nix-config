{ pkgs, userName, ... }:
{
  users.users.${userName} = {
    home = "/Users/${userName}";
    shell = pkgs.fish;
  };
  programs.fish.enable = true;
  system.primaryUser = userName;
}

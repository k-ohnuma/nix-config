{ userName, ... }:
{
  imports = [
    ./wezterm.nix
  ];

  home.sessionVariables = {
    NIX_CONFIG_PROFILE = "home-manager";
    NIX_HOME_USER = userName;
  };
}

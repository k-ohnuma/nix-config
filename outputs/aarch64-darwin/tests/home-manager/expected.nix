{
  lib,
  outputs,
  ...
}:
let
  hosts = builtins.attrNames outputs.darwinConfigurations;
in
lib.genAttrs hosts (
  name:
  let
    hmUsers = outputs.darwinConfigurations.${name}.config.home-manager.users;
    hmUser = builtins.head (builtins.attrNames hmUsers);
  in
  {
    username = hmUser;
    homeDirectory = "/Users/${hmUser}";
    stateVersion = "25.11";
    nixDarwinHost = name;
    nixDarwinUser = hmUser;
  }
)

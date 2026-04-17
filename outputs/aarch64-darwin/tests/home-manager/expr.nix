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
    hm = hmUsers.${hmUser}.home;
  in
  {
    username = hm.username;
    homeDirectory = hm.homeDirectory;
    stateVersion = hm.stateVersion;
    nixDarwinHost = hm.sessionVariables.NIX_DARWIN_HOST;
    nixDarwinUser = hm.sessionVariables.NIX_DARWIN_USER;
  }
)

{
  config,
  vars,
  userName,
  ...
}:
{
  imports = [ ../../platforms/darwin ];
  programs.git = {
    signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519_signers.pub";
    includes = [
      {
        condition = "gitdir:${vars.users.${userName}.git.gitDirPath}";
        path = vars.users.${userName}.git.gitDirConfig;
      }
    ];
    ignores = [
      "flake.nix"
      "flake.lock"
      ".envrc"
      "Justfile"
      "justfile"
    ];
  };
}

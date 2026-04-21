{
  config,
  vars,
  userName,
  ...
}:
{
  imports = [ ../../darwin ];
  programs.git = {
    signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519_signers.pub";
    settings = {
      "includeIf \"gitdir:${vars.users.${userName}.git.gitDirPath}\"".path =
        "${vars.users.${userName}.git.gitDirConfig}";
    };
  };
}

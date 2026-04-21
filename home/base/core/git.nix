{
  config,
  vars,
  userName,
  lib,
  ...
}:
let
  gitUserName = vars.users.${userName}.git.userName;
  gitUserEmail = vars.users.${userName}.git.userEmail;
in
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = lib.mkDefault "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };

    ignores = [
      ".DS_Store"
      ".direnv/"
    ];

    settings = {
      user = {
        name = gitUserName;
        email = gitUserEmail;
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;

      alias = {
        graph = "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
        gr = "log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s'";
        pushff = "push --force-with-lease --force-if-includes";
        st = "status";
        ss = "status -s";
        ad = "add";
        cm = "commit";
        stt = "status -uno";
        df = "diff --color-words";
        dc = "diff --cached";
        dp = "diff --no-prefix";
        d1 = "diff HEAD~";
        d2 = "diff HEAD~~";
        d3 = "diff HEAD~~~";
        d4 = "diff HEAD~~~~";
        co = "checkout";
        cob = "checkout -b";
        br = "branch";
        f = "fetch";
        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        amd = "commit --amend --no-edit";
        res1 = "reset HEAD^";
        wip = "!git add . && git commit -m 'wip'";
        commitwith = "!sh -c 'git add . && git commit -m \"$1\"' -";
      };

      http = {
        postBuffer = "500M";
        maxRequestBuffer = "100M";
      };

      gpg = {
        format = "ssh";
      };

      "gpg \"ssh\"" = {
        allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
      gui = {
        language = "ja";
        showIcons = true;
      };
    };
  };
}

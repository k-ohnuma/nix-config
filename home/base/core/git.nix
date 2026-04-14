{ config, ... }:
{
  programs.git = {
    enable = true;
    lfs.enable = true;

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      format = "ssh";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "ohnuma";
        email = "k.a.y.0818.k@gmail.com";
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
    };

    extraConfig = {
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

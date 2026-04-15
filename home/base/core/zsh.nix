{ config, libx, pkgs, ... }:
{
  xdg.configFile = {
    "zsh/prompt.zsh".source = libx.relativeToRoot "zsh/prompt.zsh";
    "zsh/plugins.zsh".source = libx.relativeToRoot "zsh/plugins.zsh";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = false;
    dotDir = "${config.xdg.configHome}/zsh";
    shellAliases = {
      view = "nvim -R";
      vim = "nvim";
      vi = "nvim";
      rvim = "/usr/bin/vim";

      gs = "git status";
      ggr = "git graph";

      lz = "eza --icons";
      lt = "eza --icons --tree --git-ignore";
      lg = "eza --icons --git-ignore";

      nq = "nb q --utility rg";
      nql = "nb q --utility rg --list";
      nl = "nb ls -t md";
      na = "nb a";
      ne = "nb e";

      xx = "cargo acj";
      pa = "pahcer";
      tt = "nvim +terminal";

      f = "fish";
      g = "zsh";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
        file = "share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh";
      }
      {
        name = "fast-syntax-highlighting";
        src = pkgs.zsh-fast-syntax-highlighting;
        file = "share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh";
      }
      {
        name = "fzf-tab";
        src = pkgs.zsh-fzf-tab;
        file = "share/fzf-tab/fzf-tab.plugin.zsh";
      }
      {
        name = "zsh-vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];

    initExtra = ''
      ZSH_CONFIG="$HOME/.config/zsh"

      if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
      fi

      typeset -U path PATH
      path=(
        "$HOME/.nix-profile/bin"
        "/nix/var/nix/profiles/default/bin"
        "$HOME/.local/share/mise/shims"
        "$HOME/.local/bin"
        $path
      )
      export PATH

      for f in prompt.zsh plugins.zsh; do
        [[ -f "$ZSH_CONFIG/$f" ]] && source "$ZSH_CONFIG/$f"
      done

      if command -v zoxide >/dev/null 2>&1; then
        eval "$(zoxide init zsh)"
      fi
    '';
  };
}

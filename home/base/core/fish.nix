{ pkgs, ... }:
{
  xdg.configFile = {
    "fish/functions/fish_user_key_bindings.fish".source = ./fish/functions/fish_user_key_bindings.fish;
    "fish/functions/ncc.fish".source = ./fish/functions/ncc.fish;
    "fish/functions/fish_clipboard_copy_word.fish".source = ./fish/functions/fish_clipboard_copy_word.fish;
    "fish/functions/fish_clipboard_copy_line.fish".source = ./fish/functions/fish_clipboard_copy_line.fish;
  };

  programs.fish = {
    enable = true;

    plugins = [
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
    ];

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

      xx = "cargo acj";
      pa = "pahcer";

      tt = "nvim +terminal";

      nq = "nb q --utility rg";
      nql = "nb q --utility rg --list";
      nl = "nb ls -t md";
      na = "nb a";
      ne = "nb e";

      f = "fish";
      g = "zsh";
    };

    interactiveShellInit = ''
      if test -x /opt/homebrew/bin/brew
        eval "$(/opt/homebrew/bin/brew shellenv)"
      end

      fish_add_path -m /Applications/WezTerm.app/Contents/MacOS
      fish_add_path -m $HOME/.local/bin
      fish_add_path -m $HOME/.local/share/mise/shims
      fish_add_path -m $HOME/.nix-profile/bin
      fish_add_path -m /nix/var/nix/profiles/default/bin

      fish_vi_key_bindings

      bind -M default yy fish_clipboard_copy_line
      bind -M default yiw fish_clipboard_copy_word
    '';
  };
}

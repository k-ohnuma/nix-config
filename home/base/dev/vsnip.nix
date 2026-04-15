{ config, ... }:
{
  # nix-storeへのリンクにしちゃうとvsnip-cli経由で編集できないのでoutofstore symlinkとして~/.vsnip -> このrepoのvsnipディレクトリにsym linkを貼る
  home.file.".vsnip".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nix/nix-config/vsnip";
}

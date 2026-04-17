{ ... }:
{
  # nix-darwinにnix自体の管理をさせない設定
  # Determinate Nixを使っている環境の競合回避
  nix.enable = false;

  nix.settings.auto-optimise-store = false;
  nix.gc.automatic = false;
  system.stateVersion = 6;
}

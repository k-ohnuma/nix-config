{ lib, ... }:
{
  macosSystem = import ./macosSystem.nix;

  # どこで呼んでもlibx/default.nixからのパスにできるので../つければRootから呼ぶようにできる
  relativeToRoot = lib.path.append ../.;
}

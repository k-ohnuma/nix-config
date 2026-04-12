{ lib, ... }:
{
  macosSystem = import ./macosSystem.nix;

  # どこで呼んでもlibx/default.nixからのパスにできるので../つければRootから呼ぶようにできる
  relativeToRoot = lib.path.append ../.;
  # default.nix以外のnixファイルをリストで返す
  scanPaths =
    path:
    builtins.map (f: (path + "/${f}")) (
      builtins.attrNames (
        lib.attrsets.filterAttrs (
          path: _type:
          (_type == "directory") # include directories
          || (
            (path != "default.nix") # ignore default.nix
            && (lib.strings.hasSuffix ".nix" path) # include .nix files
          )
        ) (builtins.readDir path)
      )
    );
}

{ pkgs, libx, ... }:
let
  cargoAtcoderTarget =
    if pkgs.stdenv.isDarwin && pkgs.stdenv.hostPlatform.isAarch64 then
      "aarch64-apple-darwin"
    else
      "x86_64-unknown-linux-musl";

  cargoAtcoderConfig = builtins.replaceStrings
    [ "__CARGO_ATCODER_TARGET__" ]
    [ cargoAtcoderTarget ]
    (builtins.readFile (libx.relativeToRoot "procon/cargo-atcoder/cargo-atcoder.toml"));
in
{
  xdg.configFile."cargo-atcoder.toml".text = cargoAtcoderConfig;
}

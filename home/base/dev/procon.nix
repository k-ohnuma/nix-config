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

  home.file = {
    "dev/atcoder/compete/compete.toml".source =
      libx.relativeToRoot "procon/cargo-compete/compete.toml";
    "dev/atcoder/virtual/compete.toml".source =
      libx.relativeToRoot "procon/cargo-compete/virtual.toml";

    "dev/atcoder/compete/.cargo/config.toml".source = libx.relativeToRoot "procon/config.toml";
    "dev/atcoder/virtual/.cargo/config.toml".source = libx.relativeToRoot "procon/config.toml";
    "dev/atcoder/ahc/.cargo/config.toml".source = libx.relativeToRoot "procon/config.toml";
  };
}

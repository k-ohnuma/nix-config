{ pkgs, libx, ... }:
let
  cargoAtcoderTarget =
    if pkgs.stdenv.isDarwin && pkgs.stdenv.hostPlatform.isAarch64 then
      "aarch64-apple-darwin"
    else
      "x86_64-unknown-linux-musl";

  proconTemplateRs = builtins.readFile (libx.relativeToRoot "procon/template.rs");

  cargoAtcoderConfig = builtins.replaceStrings
    [
      "__CARGO_ATCODER_TARGET__"
      "__PROCON_TEMPLATE_RS__"
    ]
    [
      cargoAtcoderTarget
      proconTemplateRs
    ]
    (builtins.readFile (libx.relativeToRoot "procon/cargo-atcoder/cargo-atcoder.toml"));

  cargoCompeteConfig = builtins.replaceStrings
    [ "__PROCON_TEMPLATE_RS__" ]
    [ proconTemplateRs ]
    (builtins.readFile (libx.relativeToRoot "procon/cargo-compete/compete.toml"));

  cargoVirtualConfig = builtins.replaceStrings
    [ "__PROCON_TEMPLATE_RS__" ]
    [ proconTemplateRs ]
    (builtins.readFile (libx.relativeToRoot "procon/cargo-compete/virtual.toml"));
in
{
  xdg.configFile."cargo-atcoder.toml".text = cargoAtcoderConfig;

  home.file = {
    "dev/atcoder/compete/compete.toml".text = cargoCompeteConfig;
    "dev/atcoder/virtual/compete.toml".text = cargoVirtualConfig;

    "dev/atcoder/compete/.cargo/config.toml".source = libx.relativeToRoot "procon/config.toml";
    "dev/atcoder/virtual/.cargo/config.toml".source = libx.relativeToRoot "procon/config.toml";
    "dev/atcoder/ahc/.cargo/config.toml".source = libx.relativeToRoot "procon/config.toml";
  };
}

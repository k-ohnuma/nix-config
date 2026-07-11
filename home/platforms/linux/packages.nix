{ pkgs, ... }:
let
  inherit (pkgs) openssl;
in
{
  home.sessionVariables = {
    PKG_CONFIG_PATH = "${openssl.dev}/lib/pkgconfig";
    OPENSSL_DIR = "${openssl.dev}";
    OPENSSL_LIB_DIR = "${openssl.out}/lib";
    OPENSSL_INCLUDE_DIR = "${openssl.dev}/include";
  };

  home.packages = with pkgs; [
    # Required by Neovim plugins such as nvim-treesitter when parsers are built locally.
    gcc
    openssl
  ];
}

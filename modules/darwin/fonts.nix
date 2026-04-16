{ pkgs, ... }:
let
  version = "0.0.4";
  bizinRegular = pkgs.stdenvNoCC.mkDerivation {
    pname = "bizin-gothic-nf-regular";
    inherit version;
    src = pkgs.fetchzip {
      url = "https://github.com/yuru7/bizin-gothic/releases/download/v${version}/BizinGothicNF_v${version}.zip";
      hash = "sha256-t9plPSwUNWcZj257ETOtYSe2/jzWNt6/sPC0ePpF3Mg=";
      stripRoot = false;
    };
    dontBuild = true;
    installPhase = ''
      install -Dm644 BizinGothicNF_v${version}/BizinGothicNF-Regular.ttf \
        $out/share/fonts/truetype/BizinGothicNF-Regular.ttf
    '';
  };
in
{
  fonts.packages = [ bizinRegular ];
}

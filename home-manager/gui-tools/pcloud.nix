{ pkgs, ... }:

let
  pcloud-22_11 = pkgs."22_11".pcloud.overrideAttrs (prev:
    let
      version = "1.14.4";
      code = "XZDh750ZBgJa45xqQ8H1ztdMFX2wVhOCTOFk";
      # Archive link's codes: https://www.pcloud.com/release-notes/linux.html
      src = pkgs.fetchzip {
        url = "https://api.pcloud.com/getpubzip?code=${code}&filename=${prev.pname}-${version}.zip";
        hash = "sha256-1KF3tF62lkT6tfeP/dMaZITXp4Vyegp3lFYdLJ49OR8=";
      };

      appimageContents = pkgs.appimageTools.extractType2 {
        name = "${prev.pname}-${version}";
        src = "${src}/pcloud";
      };
    in
    {
      inherit version;
      src = appimageContents;
    });
in
{
  home.packages = [
    pcloud-22_11
  ];
}

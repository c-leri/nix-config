{ pkgs, ... }:

let
  pcloud-22_11 = pkgs."22_11".pcloud.overrideAttrs (prev:
    let
      version = "1.14.3";
      code = "XZ7IM70ZtWFon9pgEbk4XuvzJsTduQUyGFwV";
      # Archive link's codes: https://www.pcloud.com/release-notes/linux.html
      src = pkgs.fetchzip {
        url = "https://api.pcloud.com/getpubzip?code=${code}&filename=${prev.pname}-${version}.zip";
        hash = "sha256-huv1XXghWwh/oTtOsukffZP3nnHS2K5VcsuVs6CjFYc=";
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

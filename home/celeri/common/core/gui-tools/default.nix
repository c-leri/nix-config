{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./keepassxc.nix
    ./mega.nix
    ./spicetify.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate

    libreoffice
    notesnook
    qbittorrent
    vesktop
    vlc
    vscodium-fhs
    stremio
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

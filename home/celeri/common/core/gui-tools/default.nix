{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./ghostty.nix
    ./keepassxc.nix
    ./mega.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate

    libreoffice
    notesnook
    qbittorrent
    vesktop
    vlc
    vscodium-fhs
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

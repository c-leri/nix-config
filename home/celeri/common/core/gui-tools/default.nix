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
    ./vscode.nix
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
    stremio
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

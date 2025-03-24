{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./rider.nix
    ./keepassxc.nix
    ./kitty.nix
    ./mega.nix
    ./spicetify.nix
    ./vscode.nix
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
    zen-browser
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

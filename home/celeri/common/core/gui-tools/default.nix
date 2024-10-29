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
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate

    libreoffice
    obsidian
    qbittorrent
    vesktop
    vlc
    spotify
    stremio
    zen-browser.specific
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser.specific}";
  };
}

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
    godot_4

    libreoffice
    zoom-us

    zen-browser.specific
    qbittorrent
    vesktop
    vlc
    spotify
    stremio
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser.specific}";
  };
}

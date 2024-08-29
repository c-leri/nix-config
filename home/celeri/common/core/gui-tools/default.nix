{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./keepassxc.nix
    ./kitty.nix
    ./mega.nix
    ./thunderbird.nix
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    unstable.android-studio
    unstable.jetbrains.idea-community-bin
    godot_4

    libreoffice
    zoom-us

    zen-browser.specific
    qbittorrent
    unstable.vesktop
    vlc
    spotify
    stremio
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser.specific}";
  };
}

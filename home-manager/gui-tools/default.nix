{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./gnome-terminal.nix
    ./thunderbird.nix
    ./unity+rider.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate
    jetbrains.phpstorm
    godot_4

    logseq
    onlyoffice-bin
    teams-for-linux
    zoom-us

    etcher
    prismlauncher
    qbittorrent
    vesktop
    vlc
    spotify
    stremio

    keepassxc
    mullvad-vpn
  ];

  programs = {
    firefox.enable = true;
  };
}

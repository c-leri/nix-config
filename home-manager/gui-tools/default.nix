{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./gnome-terminal.nix
    ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    jetbrains-toolbox
    godot_4

    logseq
    onlyoffice-bin

    vesktop
    etcher
    prismlauncher
    qbittorrent
    vlc
    spotify
    stremio

    keepassxc
    mullvad-vpn
  ];

  # Vesktop Config
  xdg.configFile."VencordDesktop/VencordDesktop/settings/settings.json".source = ./vesktop-settings.json;

  programs = {
    firefox.enable = true;
  };
}

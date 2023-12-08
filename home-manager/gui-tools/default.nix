{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./gnome-terminal.nix
    ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea-ultimate
    godot_4

    logseq
    onlyoffice-bin

    vesktop
    etcher
    prismlauncher
    vlc
    spotify

    keepassxc
  ];

  # Vesktop Config
  xdg.configFile."VencordDesktop/VencordDesktop/settings/settings.json".source = ./vesktop-settings.json;

  programs = {
    firefox.enable = true;
  };
}

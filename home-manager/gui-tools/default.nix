{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./wezterm.nix
    ./thunderbird.nix
    ./unity+rider.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-ultimate
    godot_4

    logseq
    onlyoffice-bin
    teams-for-linux
    zoom-us

    etcher
    floorp
    prismlauncher
    qbittorrent
    vesktop
    vlc
    spotify
    stremio

    keepassxc
    mullvad-vpn
  ];

  home.sessionVariables = {
    BROWSER = "${pkgs.floorp}/bin/floorp";
  };
}

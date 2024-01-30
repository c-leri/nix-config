{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
    ./wezterm.nix
    ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    unstable.android-studio
    unstable.jetbrains.idea-ultimate
    godot_4

    unstable.logseq
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

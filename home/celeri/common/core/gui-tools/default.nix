{pkgs, ...}: {
  imports = [
    ./vscode.nix
    ./wezterm.nix
    ./spotify.nix
    ./pcloud.nix
    ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    android-studio
    jetbrains.idea-community-bin
    godot_4

    onlyoffice-bin
    teams-for-linux
    zoom-us

    floorp
    qbittorrent
    vesktop
    vlc
    stremio

    keepassxc
  ];

  home.sessionVariables = {
    BROWSER = "${pkgs.floorp}/bin/floorp";
  };
}

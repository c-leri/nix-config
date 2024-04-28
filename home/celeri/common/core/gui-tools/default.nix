{pkgs, ...}: {
  imports = [
    ./vscode.nix
    ./wezterm.nix
    ./spotify.nix
    ./pcloud.nix
    ./thunderbird.nix
  ];

  home.packages = with pkgs; [
    unstable.android-studio
    unstable.jetbrains.idea-community
    godot_4

    onlyoffice-bin
    teams-for-linux
    zoom-us

    floorp
    qbittorrent
    unstable.vesktop
    vlc
    stremio

    keepassxc
  ];

  home.sessionVariables = {
    BROWSER = "${pkgs.floorp}/bin/floorp";
  };
}
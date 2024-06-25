{pkgs, ...}: {
  imports = [
    ./keepassxc.nix
    ./mega.nix
    ./spotify.nix
    ./thunderbird.nix
    ./vscode.nix
    ./wezterm.nix
  ];

  home.packages = with pkgs; [
    unstable.android-studio
    unstable.jetbrains.idea-community-bin
    godot_4

    onlyoffice-bin
    zoom-us

    bottles
    floorp
    qbittorrent
    unstable.vesktop
    vlc
    stremio
  ];

  home.sessionVariables = {
    BROWSER = "${pkgs.floorp}/bin/floorp";
  };
}

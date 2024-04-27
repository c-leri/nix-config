{pkgs, ...}: {
  imports = [
    ./vscode.nix
    ./wezterm.nix
    ./thunderbird.nix
    ./spotify.nix
    ./pcloud.nix
  ];

  home.packages = with pkgs; [
    unstable.android-studio
    unstable.jetbrains.idea-ultimate
    godot_4

    unstable.logseq
    onlyoffice-bin
    teams-for-linux
    zoom-us

    floorp
    prismlauncher
    qbittorrent
    unstable.vesktop
    vlc
    unstable.stremio

    keepassxc
    mullvad-vpn
  ];

  home.sessionVariables = {
    BROWSER = "${pkgs.floorp}/bin/floorp";
  };
}

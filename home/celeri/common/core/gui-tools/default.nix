{ pkgs, ... }:
{
  imports = [
    ./discord.nix
    ./ghostty.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea

    cider-2
    keepassxc
    megasync
    notesnook
    qbittorrent
    stremio-linux-shell
    vlc
  ];
}

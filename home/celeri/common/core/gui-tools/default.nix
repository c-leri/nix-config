{ pkgs, ... }:
{
  imports = [
    ./discord.nix
    ./ghostty.nix
    ./keepassxc.nix
    ./mpv.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea

    cider-2
    megasync
    notesnook
    qbittorrent
    stremio-linux-shell
  ];
}

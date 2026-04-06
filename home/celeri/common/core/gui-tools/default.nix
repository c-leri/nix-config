{
  pkgs,
  lib,
  ...
}:
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

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

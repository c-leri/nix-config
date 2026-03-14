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
    libreoffice
    megasync
    notesnook
    qbittorrent
    vlc
    vscodium-fhs
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

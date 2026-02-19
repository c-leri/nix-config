{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./discord.nix
    ./ghostty.nix
    ./keepassxc.nix
    ./mega.nix
    ./zen.nix
  ];

  home.packages = with pkgs; [
    jetbrains.idea

    unstable.cider-2
    libreoffice
    notesnook
    qbittorrent
    vlc
    vscodium-fhs
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

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
    # Uncomment when https://github.com/NixOS/nixpkgs/pull/503035 is fixed
    # stremio-linux-shell
    vlc
    vscodium-fhs
  ];

  home.sessionVariables = {
    BROWSER = "${lib.getExe pkgs.zen-browser}";
  };
}

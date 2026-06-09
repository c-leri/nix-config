{ pkgs, ... }:
{
  imports = [
    ./gamemode.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
    osu-lazer-bin
    prismlauncher
    r2modman
    shadps4
    shadps4-qtlauncher
    winetricks
  ];
}

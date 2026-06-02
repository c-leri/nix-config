{ pkgs, ... }:
{
  imports = [
    ./gamemode.nix
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
    r2modman
    shadps4
    shadps4-qtlauncher
    winetricks
  ];
}

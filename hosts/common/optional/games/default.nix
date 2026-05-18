{ pkgs, ... }:
{
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
    r2modman
    shadps4
  ];

  programs.gamemode.enable = true;
}

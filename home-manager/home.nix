{ config, pkgs, ... }:

{
  imports = [
    ./apps/fish.nix
    ./apps/helix.nix
    ./apps/git.nix
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    nixpkgs-fmt
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    firefox.enable = true;
  };     
}

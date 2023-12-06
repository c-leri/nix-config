{ config, pkgs, ... }:

{
  imports = [
    ./apps/fish.nix
    ./apps/helix.nix
    ./apps/git.nix
    ./apps/gnome-terminal.nix
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";
  home.stateVersion = "23.11";
  home.packages = with pkgs; [
    nixpkgs-fmt
    gnome.gnome-tweaks
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    firefox.enable = true;
  };     
}

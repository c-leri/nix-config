{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
  ];

  home.packages = with pkgs; [
    any-nix-shell
    fd
    glow
    hyfetch
    mprocs
    pipx
    viu
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
  };
}

{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
  ];

  home.packages = with pkgs; [
    imagemagick
    fd
    ffmpeg
    glow
    hyfetch
    lazydocker
    mprocs
    tldr
    viu
    wasmer
  ];

  programs = {
    bat.enable = true;
    bottom.enable = true;
    direnv.enable = true;
    ripgrep.enable = true;
  };
}

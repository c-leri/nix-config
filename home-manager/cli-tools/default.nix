{ pkgs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    imagemagick
    fd
    ffmpeg
    glow
    lazydocker
    mprocs
    tldr
    viu
    wasmer
  ];

  programs = {
    bottom.enable = true;
    direnv.enable = true;
    ripgrep.enable = true;
  };
}

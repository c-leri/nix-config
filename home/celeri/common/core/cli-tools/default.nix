{pkgs, ...}: {
  imports = [
    ./atuin.nix
    ./bat.nix
    ./bottom.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    cachix
    manix
    nix-output-monitor

    fd
    glow
    mprocs
    tldr

    imagemagick
    ffmpeg
  ];

  programs = {
    direnv.enable = true;
    ripgrep.enable = true;
  };
}

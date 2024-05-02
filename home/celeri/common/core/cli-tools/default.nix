{pkgs, ...}: {
  imports = [
    ./helix
    ./atuin.nix
    ./bat.nix
    ./bottom.nix
    ./fish.nix
    ./git.nix
    ./starship.nix
    ./yazi.nix
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

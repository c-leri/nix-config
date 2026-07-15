{ pkgs, ... }:
{
  imports = [
    ./bat.nix
    ./bottom.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
    ./nix-your-shell.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    devenv
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

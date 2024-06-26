{pkgs, ...}: {
  imports = [
    ./bat.nix
    ./bottom.nix
    ./fzf.nix
    ./git.nix
    ./helix.nix
    ./starship.nix
    ./yazi.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
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

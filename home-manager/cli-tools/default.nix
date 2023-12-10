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
    lazydocker
    mprocs
    pipx
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

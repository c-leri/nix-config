{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    cachix
    imagemagick
    fd
    ffmpeg
    glow
    lazydocker
    mprocs
    unstable.nh
    nix-output-monitor
    tldr
    wasmer
  ];

  programs = {
    bottom.enable = true;
    direnv.enable = true;
    ripgrep.enable = true;
    atuin = {
      enable = true;
      flags = ["--disable-up-arrow"];
      settings = {
        dialect = "uk";
        update_check = false;
      };
    };
  };
}

{pkgs, ...}: {
  imports = [
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./bat.nix
  ];

  home.packages = with pkgs; [
    cachix
    unstable.manix
    unstable.nh
    nix-output-monitor

    fd
    glow
    mprocs
    tldr

    imagemagick
    ffmpeg
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

{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (rust-bin.stable.latest.default.override { extensions = [ "rust-analyzer" ]; })
    cargo-watch
    gcc
  ];

  programs = {
    bacon = {
      enable = true;
      settings = { };
    };
  };
}

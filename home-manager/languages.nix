{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    elixir
    nodejs_20
    nodePackages.pnpm
    python3
    rustup
  ];

  programs = {
    bacon = {
      enable = true;
      settings = { };
    };
  };
}

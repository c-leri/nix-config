{ config, pkgs, ... }:

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

  # Set the PNPM_HOME env variable
  home.sessionVariables = {
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  # Add PNPM_HOME to the path
  home.sessionPath = [
    "$PNPM_HOME"
  ];
}

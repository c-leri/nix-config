{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    elixir
    jdk21
    nodejs_20
    nodePackages.pnpm
    python3
    (rust-bin.fromRustupToolchainFile ./rust-toolchain.toml)
    cargo-watch
    zig
  ];

  programs = {
    bacon = {
      enable = true;
      settings = { };
    };
    go.enable = true;
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

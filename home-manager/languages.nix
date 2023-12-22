{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bun
    elixir
    jdk21
    nodejs_20
    nodePackages.pnpm
    php83
    php83Packages.composer
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

  home.sessionVariables = {
    # Set the PNPM_HOME env variable
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  home.sessionPath = [
    # Add PNPM_HOME to the path
    "$PNPM_HOME"
    # Add the composer bin directory to the path
    "$HOME/.config/composer/vendor/bin"
  ];
}

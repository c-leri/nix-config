{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    unstable.bun
    jdk21
    nodejs_20
    unstable.nodePackages.pnpm
    php83
    php83Packages.composer
    python3
    (rust-bin.stable.latest.default.override {
      extensions = [ "rust-analyzer" ];
    })
    cargo-watch
  ];

  programs = {
    bacon = {
      enable = true;
      settings = { };
    };
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

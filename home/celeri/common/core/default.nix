{config, ...}: {
  imports = [
    # Services
    ./services/mpris-proxy.nix

    # Theming
    ./gnome.nix
    ./theme.nix

    # Tools
    ./cli-tools
    ./gui-tools
    ./languages
  ];

  home.sessionVariables = {
    # Tell nh where to find the nixos and home-manager config flake
    FLAKE = "${config.home.homeDirectory}/nix-config";
  };
}

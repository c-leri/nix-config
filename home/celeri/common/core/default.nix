{inputs, ...}: {
  imports = [
    # Catppuccin Module
    inputs.catppuccin.homeManagerModules.catppuccin

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

  # Enable the ssh agent
  services.ssh-agent.enable = true;

  xdg.enable = true;

  # Choose catppuccin flavour
  catppuccin.flavour = "macchiato";
}

{
  imports = [
    # Sops
    ./sops.nix

    # Services
    ./services/mpris-proxy.nix

    # Theming
    ./gnome
    ./theme.nix

    # Tools
    ./cli-tools
    ./gui-tools
    ./languages
  ];

  # Enable the ssh agent
  services.ssh-agent.enable = true;

  xdg.enable = true;
}

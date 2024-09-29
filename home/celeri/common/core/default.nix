{
  imports = [
    # Sops
    ./sops.nix

    # SSH config
    ./ssh.nix

    # Services
    ./services/mpris-proxy.nix

    # Theming
    ./theme.nix

    # Tools
    ./cli-tools
    ./gui-tools
    ./languages
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";

  xdg.enable = true;
}

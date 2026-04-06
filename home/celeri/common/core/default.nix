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

  home.file = {
    face = {
      target = ".face";
      source = ./face.jpg;
    };
  };

  xdg.enable = true;
}

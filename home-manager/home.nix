{
  imports = [
    # nixpkgs config
    ../nixpkgs.nix

    ./cli-tools
    ./gui-tools
    ./languages.nix
    ./gnome.nix
    ./hyprland
    ./theme.nix
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";
  home.stateVersion = "23.11";

  # Bluetooth media control
  services.mpris-proxy.enable = true;
}

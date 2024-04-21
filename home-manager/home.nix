{
  imports = [
    ./cli-tools
    ./gui-tools
    ./languages.nix
    ./gnome.nix
    ./theme.nix
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";
  home.stateVersion = "23.11";

  # Nixpkgs config
  xdg.configFile."nixpkgs/config.nix".source = ../nixpkgs-config.nix;

  # Bluetooth media control
  services.mpris-proxy.enable = true;
}

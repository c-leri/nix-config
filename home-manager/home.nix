{
  imports = [
    ./gnome.nix
    ./languages.nix
    ./cli-tools
    ./gui-tools
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";
  home.stateVersion = "23.11";

  # Nixpkgs config
  nixpkgs.config = import ../nixpkgs-config.nix;
}

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
  xdg.configFile."nixpkgs/config.nix".source = ../nixpkgs-config.nix;
}

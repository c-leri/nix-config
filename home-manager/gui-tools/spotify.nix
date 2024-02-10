{ pkgs, spicetify-nix, ... }:
let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [
    spicetify-nix.homeManagerModule
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
    enabledExtensions = with spicePkgs.extensions; [
      shuffle
      volumePercentage
    ];
  };
}
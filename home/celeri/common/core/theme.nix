{ pkgs, ... }:
{
  stylix.icons = {
    enable = true;
    package = pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
    light = "Papirus-Light";
  };

  gtk.gtk4.theme = null;
}

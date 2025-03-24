{
  pkgs,
  lib,
  ...
}: {
  stylix.iconTheme = {
    enable = true;
    package = lib.mkDefault pkgs.papirus-icon-theme;
    dark = "Papirus-Dark";
    light = "Papirus-Light";
  };
}

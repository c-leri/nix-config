{pkgs, ...}: {
  stylix.iconTheme = {
    enable = true;
    package = pkgs.papirus-icon-theme.override {color = "cyan";};
    dark = "Papirus-Dark";
    light = "Papirus-Light";
  };
}

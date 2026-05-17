{ pkgs, ... }:
{
  stylix = {
    image = ./background.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    opacity = {
      applications = 0.9;
      desktop = 0.9;
      terminal = 0.9;
    };
  };
}

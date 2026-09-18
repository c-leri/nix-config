{ pkgs, ... }:
{
  stylix = {
    image = ../../public/wallpapers/TRONC.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
    polarity = "dark";
  };
}

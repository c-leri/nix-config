{pkgs, ...}: {
  stylix = {
    image = ./background.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-soft.yaml";
  };
}

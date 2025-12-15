{
  pkgs,
  config,
  ...
}: {
  stylix = {
    enable = true;
    cursor = {
      package = pkgs.google-cursor;
      name = "GoogleDot-Black";
      size = 24;
    };
    fonts = {
      sansSerif = {
        package = pkgs.unstable.adwaita-fonts;
        name = "Adwaita Sans";
      };
      serif = config.stylix.fonts.sansSerif;
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };
    };
  };
}

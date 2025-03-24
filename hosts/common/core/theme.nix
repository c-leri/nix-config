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
        package = pkgs.nerdfonts.override {fonts = ["CascadiaCode"];};
        name = "CaskaydiaCove Nerd Font";
      };
    };
    # Gnome won't start after logging in otherwise
    targets.gnome.enable = false;
  };
}

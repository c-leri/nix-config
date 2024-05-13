{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    # Catppuccin Module
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # Choose catppuccin flavour
  catppuccin.flavour = "macchiato";

  home.sessionVariables = {
    # Tell QT to use x11 (wayland seems to be broken for now)
    QT_QPA_PLATFORM = "xcb";
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.google-cursor;
    name = "GoogleDot-Black";
    size = 24;
  };

  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      gnomeShellTheme = true;
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme.override {color = "magenta";};
      name = "Papirus";
    };
  };
}

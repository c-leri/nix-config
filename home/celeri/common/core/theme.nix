{
  inputs,
  pkgs,
  config,
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

    theme = {
      package = pkgs.orchis-theme.override {
        tweaks = [
          "solid"
          "primary"
          "submenu"
        ];
      };
      name = "Orchis-Purple-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme.override {color = "magenta";};
      name = "Papirus";
    };
  };

  xdg.configFile = {
    "gtk-4.0/assets".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/assets";
    "gtk-4.0/gtk.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk.css";
    "gtk-4.0/gtk-dark.css".source = "${config.gtk.theme.package}/share/themes/${config.gtk.theme.name}/gtk-4.0/gtk-dark.css";
  };
}

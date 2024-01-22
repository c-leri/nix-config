{ pkgs, ... }:

{
  home.packages = with pkgs; with gnomeExtensions; [
    gnome.gnome-tweaks
    app-icons-taskbar
    appindicator
    blur-my-shell
    caffeine
    dash-to-dock
    gnome-40-ui-improvements
    noannoyance-fork
    transparent-window-moving
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "GoogleDot-Black";
      icon-theme = "Papirus";
    };
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "GoogleDot-Black";
      package = pkgs.google-cursor;
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk";
    style.name = "adwaita-dark";
  };
}

{pkgs, ...}: {
  home.packages = with pkgs.gnomeExtensions; [
    app-icons-taskbar
    appindicator
    blur-my-shell
    coverflow-alt-tab
    dash-to-dock
    espresso
    gnome-40-ui-improvements
    just-perfection
    quick-settings-tweaker
    transparent-window-moving
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "aztaskbar@aztaskbar.gitlab.com"
        "blur-my-shell@aunetx"
        "CoverflowAltTab@palatis.blogspot.com"
        "dash-to-dock@micxgx.gmail.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
        "espresso@coadmunkee.github.com"
        "gnome-ui-tune@itstime.tech"
        "just-perfection-desktop@just-perfection"
        "quick-settings-tweaks@qwreey"
        "transparent-window-moving@noobsai.github.com"
      ];
    };
    "org/gnome/shell/extensions/aztaskbar" = {
      favorites = false;
      indicator-color-focused = "rgb(198,160,246)";
    };
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = false;
    };
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
    };
    "org/gnome/shell/extensions/coverflowalttab" = {
      position = "Top";
      hide-panel = false;
      dim-factor = 0.0;
      switch-application-behaves-like-switch-windows = true;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      transparency-mode = "FIXED";
      background-opacity = 0.0;
      dock-position = "BOTTOM";
      running-indicator-style = "DOTS";
      show-trash = false;
      hot-keys = false;
    };
    "org/gnome/shell/extensions/espresso" = {
      show-notifications = false;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      events-button = false;
      theme = false;
      weather = false;
      window-demands-attention-focus = true;
      world-clock = false;
      startup-status = 0;
    };
    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      add-dnd-quick-toggle-enabled = false;
      datemenu-remove-media-control = true;
      datemenu-remove-notifications = false;
      input-always-show = false;
      input-show-selected = false;
      media-control-compact-mode = true;
      media-control-enabled = true;
      notifications-enabled = false;
      output-show-selected = false;
      user-removed-buttons = ["DarkModeToggle"];
      volume-mixer-enabled = true;
      volume-mixer-position = "bottom";
    };
    "org/gnome/shell/extensions/transparent-window-moving" = {
      transparent-on-resizing = false;
    };
  };
}

{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs.gnomeExtensions; [
    app-icons-taskbar
    appindicator
    blur-my-shell
    caffeine
    coverflow-alt-tab
    dash-to-dock
    gnome-40-ui-improvements
    just-perfection
    quick-settings-tweaker
    transparent-window-moving
    user-themes
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "blur-my-shell@aunetx"
        "CoverflowAltTab@palatis.blogspot.com"
        "appindicatorsupport@rgcjonas.gmail.com"
        "aztaskbar@aztaskbar.gitlab.com"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "gnome-ui-tune@itstime.tech"
        "just-perfection-desktop@just-perfection"
        "quick-settings-tweaks@qwreey"
        "transparent-window-moving@noobsai.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
      ];
    };
    "org/gnome/shell/extensions/caffeine" = {
      countdown-timer = 0;
    };
    "org/gnome/shell/extensions/coverflowalttab" = {
      position = "Top";
      hide-panel = false;
      dim-factor = 0.0;
      switch-application-behaves-like-switch-windows = true;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      background-opacity = 0.0;
      disable-overview-on-startup = true;
      dock-position = "BOTTOM";
      hot-keys = false;
    };
    "org/gnome/shell/extensions/just-perfection" = {
      events-button = false;
      theme = false;
      weather = false;
      window-demands-attention-focus = true;
      world-clock = false;
    };
    "org/gnome/shell/extensions/quick-settings-tweaks" = {
      add-dnd-quick-toggle-enabled = true;
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
    "org/gnome/shell/extensions/user-theme" = {
      name = config.gtk.theme.name;
    };
  };
}

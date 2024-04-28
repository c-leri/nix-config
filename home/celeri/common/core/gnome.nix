{pkgs, ...}: {
  home.packages = with pkgs;
  with gnomeExtensions; [
    gnome.gnome-tweaks
    app-icons-taskbar
    appindicator
    blur-my-shell
    caffeine
    coverflow-alt-tab
    dash-to-dock
    gnome-40-ui-improvements
    just-perfection
    noannoyance-fork
    quick-settings-tweaker
    transparent-window-moving
    user-themes
  ];

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
    };
  };
}

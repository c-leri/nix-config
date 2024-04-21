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
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };
}

{
  pkgs,
  config,
  ...
}: let
  background = ../../../../../background.jpg;
in {
  imports = [
    ./extensions.nix
  ];

  home.packages = with pkgs; [
    gnome-tweaks
  ];

  dconf.settings = {
    "org/gnome/tweaks" = {
      show-extensions-notice = false;
    };

    "org/gnome/mutter" = {
      experimental-features = ["scale-monitor-framebuffer"];
      center-new-windows = true;
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/desktop/interface" = {
      color-scheme =
        if config.catppuccin.flavor == "latte"
        then "default"
        else "prefer-dark";
      enable-hot-corners = false;
      show-clock-weekday = true;
      show-battery-percentage = true;
    };
    "org/gnome/desktop/background" = {
      picture-uri = "${background}";
      picture-uri-dark = "${background}";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri = "${background}";
    };
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    "org/gnome/desktop/peripherals/touchpad" = {
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = true;
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };
  };
}

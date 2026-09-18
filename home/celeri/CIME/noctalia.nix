{ config, lib, ... }: {
  programs.noctalia = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn, steam)
      hooks.started = "megasync & keepassxc & mullvad-vpn & steam -silent &";
      # Dock pinned apps
      dock.pinned = [
        "zen-beta"
        "org.gnome.Nautilus"
        "com.mitchellh.ghostty"
        "steam"
        "net.lutris.Lutris"
        "vesktop"
        "cider-2"
      ];
      # Wallpaper
      wallpaper.default.path = lib.mkForce "${config.programs.noctalia.settings.wallpaper.directory}/CIME.jpg";
      # Opacity
      bar.default.background_opacity = 0.9;
      shell.panel.transparency_mode = "soft";
    };
  };

  wayland.windowManager.niri = {
    settings = {
      _children = [
        # Disable xray effect for noctalia pannels
        {
          layer-rule = {
            match._props = {
              namespace = ''^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$'';
            };
            background-effect.xray = false;
          };
        }
        # Enable blur on noctalia window switcher
        {
          layer-rule = {
            match._props = {
              namespace = "noctalia-window-switcher";
            };
            background-effect = {
              blur = true;
              xray = false;
            };
          };
        }
      ];
    };
  };
}

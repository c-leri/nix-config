{
  programs.noctalia = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn, steam)
      hooks.started = "megasync & keepassxc & mullvad-vpn & steam -silent &";
      dock = {
        # Dock pinned apps
        pinned = [
          "zen-beta"
          "nautilus"
          "ghostty"
          "steam"
          "lutris"
          "vesktop"
          "cider"
        ];
      };
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

{
  wayland.windowManager.niri = {
    settings = {
      _children = [
        # Enable blur effect on all windows, without xray
        {
          window-rule = {
            background-effect = {
              blur = true;
              xray = false;
            };
          };
        }
        # Place steam notifications at the bottom right of the screen, unfocused
        {
          window-rule = {
            match._props = {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            };
            default-floating-position._props = {
              relative-to = "bottom-right";
              x = 10;
              y = 10;
            };
            open-focused = false;
          };
        }
        # Place the steam on screen keyboard at the bottom of the screen, unfocused
        {
          window-rule = {
            match._props = {
              app-id = "steam";
              title = "^Steam Input";
            };
            default-floating-position._props = {
              relative-to = "bottom";
              x = 0;
              y = 10;
            };
            open-focused = false;
          };
        }
      ];
    };
  };
}

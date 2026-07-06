{
  programs.niri = {
    settings = {
      window-rules = [
        {
          # Enable blur effect on all windows, without xray
          background-effect = {
            blur = true;
            xray = false;
          };
        }
        # Place steam notifications at the bottom right of the screen, unfocused
        {
          matches = [
            {
              app-id = "steam";
              title = "^notificationtoasts_\\d+_desktop$";
            }
          ];
          default-floating-position = {
            x = 10;
            y = 10;
            relative-to = "bottom-right";
          };
          open-focused = false;
        }
        # Place the steam on screen keyboard at the bottom of the screen, unfocused
        {
          matches = [
            {
              app-id = "steam";
              title = "^Steam Input";
            }
          ];
          default-floating-position = {
            x = 0;
            y = 10;
            relative-to = "bottom";
          };
          open-focused = false;
        }
      ];
    };
  };
}

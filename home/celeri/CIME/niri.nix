{
  programs.niri = {
    settings = {
      screenshot-path = "~/Images/Captures d’écran/Capture d’écran du %Y-%m-%d %H-%M-%S.png";
      window-rules = [
        # Window rule to place steam notifications at the bottom right of the screen
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
        }
      ];
      outputs = {
        "DP-2" = {
          mode = {
            width = 2560;
            height = 1440;
            refresh = 170.001;
          };
          position = {
            x = 0;
            y = 0;
          };
          variable-refresh-rate = "on-demand";
        };
        "HDMI-A-1" = {
          enable = false;
          mode = {
            width = 3840;
            height = 2160;
            refresh = 60.;
          };
          position = {
            x = 2560;
            y = 0;
          };
          scale = 1.5;
        };
      };
    };
  };
}

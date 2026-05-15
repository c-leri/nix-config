{
  programs.niri = {
    settings = {
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
    };
  };
}

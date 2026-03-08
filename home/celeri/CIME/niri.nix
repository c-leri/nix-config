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
    };
  };
}

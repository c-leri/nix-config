{
  programs.umbriel.settings = {
    window_rule = [
      # Apply blur to all windows
      {
        blur = true;
        blur_optimized = false;
      }
      {
        match.app_id = "^steam_app_.*$";
        confine_pointer = true;
      }
      # Place steam notifications at the bottom right of the screen, unfocused
      {
        match.title = "^notificationtoasts_.+_desktop";
        default_focused = false;
        default_pinned = true;
        default_position = {
          x = 10;
          y = 10;
          anchor = "bottom_right";
        };
      }
      # Place the steam on screen keyboard at the bottom of the screen, unfocused
      {
        match = {
          app_id = "^steam$";
          title = "^Steam Input.+";
        };
        default_focused = false;
        default_pinned = true;
        default_position = {
          x = 0;
          y = 10;
          anchor = "bottom";
        };
      }
    ];
  };
}

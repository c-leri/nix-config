{ config, ... }: {
  wayland.windowManager.niri = {
    enable = true;
    settings = {
      # Hide window decoration
      prefer-no-csd = true;
      input.keyboard.numlock = true;
      hotkey-overlay.skip-at-startup = true;
      cursor.hide-after-inactive-ms = 500;
      layout = {
        default-column-width.proportion = 0.5;
        focus-ring = with config.lib.stylix.colors.withHashtag; {
          active-color = base0D;
          inactive-color = base03;
        };
      };
      binds = {
        "Mod+F1" = {
          show-hotkey-overlay = { };
        };
        "Mod+D" = {
          _props.repeat = false;
          toggle-overview = { };
        };
        "Mod+Q" = {
          _props.repeat = false;
          close-window = { };
        };
        "Mod+Shift+E" = {
          quit = { };
        };
        "Ctrl+Shift+space" = {
          _props.hotkey-overlay-title = "Switch Keyboard Layout";
          switch-layout = "next";
        };
        # Open default terminal
        "Mod+T" = {
          _props.hotkey-overlay-title = "Open terminal";
          spawn = [ "xdg-terminal-exec" ];
        };
        # Maximize/fullscreen window/column
        "Mod+F" = {
          maximize-column = { };
        };
        "Mod+Shift+F" = {
          fullscreen-window = { };
        };
        "Mod+Ctrl+F" = {
          expand-column-to-available-width = { };
        };
        "Mod+M" = {
          maximize-window-to-edges = { };
        };
        # Move focus in workspace
        "Mod+Left" = {
          focus-column-left = { };
        };
        "Mod+Down" = {
          focus-window-down = { };
        };
        "Mod+Up" = {
          focus-window-up = { };
        };
        "Mod+Right" = {
          focus-column-right = { };
        };
        # Move windows/columns in workspace
        "Mod+Ctrl+Left" = {
          move-column-left = { };
        };
        "Mod+Ctrl+Down" = {
          move-window-down = { };
        };
        "Mod+Ctrl+Up" = {
          move-window-up = { };
        };
        "Mod+Ctrl+Right" = {
          move-column-right = { };
        };
        # Move focus accross workspaces
        "Mod+Page_Down" = {
          focus-workspace-down = { };
        };
        "Mod+Page_Up" = {
          focus-workspace-up = { };
        };
        # Move windows/columns accross workspaces
        "Mod+Ctrl+Page_Down" = {
          move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+Page_Up" = {
          move-column-to-workspace-up = { };
        };
        "Mod+Shift+Page_Down" = {
          move-workspace-down = { };
        };
        "Mod+Shift+Page_Up" = {
          move-workspace-up = { };
        };
        # Scroll focus
        "Mod+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          focus-workspace-up = { };
        };
        "Mod+WheelScrollRight" = {
          focus-column-right = { };
        };
        "Mod+WheelScrollLeft" = {
          focus-column-left = { };
        };
        "Mod+Shift+WheelScrollDown" = {
          focus-column-right = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          focus-column-left = { };
        };
        # Scroll columns
        "Mod+Ctrl+WheelScrollDown" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          _props.cooldown-ms = 150;
          move-column-to-workspace-up = { };
        };
        "Mod+Ctrl+WheelScrollRight" = {
          move-column-right = { };
        };
        "Mod+Ctrl+WheelScrollLeft" = {
          move-column-left = { };
        };
        "Mod+Ctrl+Shift+WheelScrollDown" = {
          move-column-right = { };
        };
        "Mod+Ctrl+Shift+WheelScrollUp" = {
          move-column-left = { };
        };
        # Move focus to specific workspace
        "Mod+1" = {
          focus-workspace = 1;
        };
        "Mod+2" = {
          focus-workspace = 2;
        };
        "Mod+3" = {
          focus-workspace = 3;
        };
        "Mod+4" = {
          focus-workspace = 4;
        };
        "Mod+5" = {
          focus-workspace = 5;
        };
        "Mod+6" = {
          focus-workspace = 6;
        };
        "Mod+7" = {
          focus-workspace = 7;
        };
        "Mod+8" = {
          focus-workspace = 8;
        };
        "Mod+9" = {
          focus-workspace = 9;
        };
        # Move column to specific workspace
        "Mod+Ctrl+1" = {
          move-column-to-workspace = 1;
        };
        "Mod+Ctrl+2" = {
          move-column-to-workspace = 2;
        };
        "Mod+Ctrl+3" = {
          move-column-to-workspace = 3;
        };
        "Mod+Ctrl+4" = {
          move-column-to-workspace = 4;
        };
        "Mod+Ctrl+5" = {
          move-column-to-workspace = 5;
        };
        "Mod+Ctrl+6" = {
          move-column-to-workspace = 6;
        };
        "Mod+Ctrl+7" = {
          move-column-to-workspace = 7;
        };
        "Mod+Ctrl+8" = {
          move-column-to-workspace = 8;
        };
        "Mod+Ctrl+9" = {
          move-column-to-workspace = 9;
        };
        # Move window left/right
        "Mod+BracketLeft" = {
          consume-or-expel-window-left = { };
        };
        "Mod+BracketRight" = {
          consume-or-expel-window-right = { };
        };
        # Floating windows
        "Mod+V" = {
          toggle-window-floating = { };
        };
        "Mod+Shift+V" = {
          switch-focus-between-floating-and-tiling = { };
        };
        # Tabbed column
        "Mod+W" = {
          toggle-column-tabbed-display = { };
        };
        # Screenshot
        "Print" = {
          screenshot = { };
        };
        "Ctrl+Print" = {
          screenshot-screen = { };
        };
        "Alt+Print" = {
          screenshot-window = { };
        };
      };
    };
  };
}

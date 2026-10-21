{ inputs, ... }: {
  imports = [
    inputs.umbriel.homeModules.default
  ];

  programs.umbriel = {
    enable = true;
    settings = {
      general = {
        xwayland = true;
        # Pass physical resolutions to x11 apps
        xwayland_native_resolution = true;
        # Pass scale and cursor theme through xsettings
        xwayland_xsettings = true;
        show_cheatsheet = false;
      };
      input = {
        keyboard = {
          numlock_toggle = true;
        };
      };
      layout = {
        mode = "scrolling";
        extent_presets = [
          0.333
          0.5
          0.667
        ];
        scrolling = {
          # New windows take half the screen in scrolling layout
          default_extent_fraction = 0.5;
          center_underfull_strip = false;
        };
      };
      appearance = {
        prefer_no_csd = true;
        border_width = 2;
        corner_radius = 10;
        blur = {
          enabled = true;
          passes = 3;
          radius = 3;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.1;
        };
      };
      window_rule = [
        {
          match.app_id = "^dev.noctalia.UmbrielSharePicker$";
          default_floating = true;
          default_floating_size_px = {
            width = 800;
            height = 600;
          };
        }
        {
          match.title = "^(Picture-in-Picture|Picture in picture)$";
          default_floating = true;
          default_maximize = false;
          default_position = {
            x = 20;
            y = 20;
            anchor = "bottom_right";
          };
        }
        {
          match.app_id = "^(MEGAsync|mullvad-vpn)$";
          default_floating = true;
          default_position = {
            x = 10;
            y = 10;
            anchor = "top_right";
          };
        }
      ];
      keybinds = {
        "Mod+F1" = {
          action = "cheatsheet-toggle";
          repeat = false;
        };
        "Mod+D" = {
          action = "overview-toggle";
          repeat = false;
        };
        "Mod+Q" = {
          action = "window-close";
          repeat = false;
        };
        "Mod+Escape" = "session-quit";
        "Mod+Shift+Escape" = {
          action = "shortcuts-inhibit-toggle";
          allow_when_inhibited = true;
          repeat = false;
        };
        "Ctrl+Shift+Space" = "keyboard-layout-next";
        # Open default terminal
        "Mod+T" = "spawn:xdg-terminal-exec";
        # Fullscreen/Maximize window
        "Mod+F" = {
          action = "window-toggle-maximize";
          repeat = false;
        };
        "Mod+Shift+F" = {
          action = "window-toggle-fullscreen";
          repeat = false;
        };
        "Mod+M" = {
          action = "window-toggle-maximize-to-edges";
          repeat = false;
        };
        # Floating windows
        "Mod+V" = {
          action = "window-toggle-floating";
          repeat = false;
        };
        "Mod+Shift+V" = {
          action = "window-focus-switch-floating";
          repeat = false;
        };
        # Tabbed columns
        "Mod+W" = {
          action = "column-toggle-tabbed";
          repeat = false;
        };
        "Mod+Alt+Right" = "column-focus-tab-next";
        "Mod+Alt+Left" = "column-focus-tab-previous";
        # Focus/Move window
        "Mod+Left" = "window-focus-or-output-left";
        "Mod+Right" = "window-focus-or-output-right";
        "Mod+Up" = "window-focus-or-workspace-up";
        "Mod+Down" = "window-focus-or-workspace-down";
        "Mod+Ctrl+Left" = "window-move-or-output-left";
        "Mod+Ctrl+Right" = "window-move-or-output-right";
        "Mod+Ctrl+Up" = "window-move-or-workspace-up";
        "Mod+Ctrl+Down" = "window-move-or-workspace-down";
        # Workspaces
        "Mod+1" = "workspace-switch:1";
        "Mod+2" = "workspace-switch:2";
        "Mod+3" = "workspace-switch:3";
        "Mod+4" = "workspace-switch:4";
        "Mod+5" = "workspace-switch:5";
        "Mod+6" = "workspace-switch:6";
        "Mod+7" = "workspace-switch:7";
        "Mod+8" = "workspace-switch:8";
        "Mod+9" = "workspace-switch:9";
        "Mod+Shift+1" = "window-move-to-workspace:1";
        "Mod+Shift+2" = "window-move-to-workspace:2";
        "Mod+Shift+3" = "window-move-to-workspace:3";
        "Mod+Shift+4" = "window-move-to-workspace:4";
        "Mod+Shift+5" = "window-move-to-workspace:5";
        "Mod+Shift+6" = "window-move-to-workspace:6";
        "Mod+Shift+7" = "window-move-to-workspace:7";
        "Mod+Shift+8" = "window-move-to-workspace:8";
        "Mod+Shift+9" = "window-move-to-workspace:9";
        "Mod+WheelDown" = "workspace-next";
        "Mod+WheelUp" = "workspace-previous";
      };
    };
  };
}

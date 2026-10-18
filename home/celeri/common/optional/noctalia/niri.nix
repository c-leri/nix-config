{ lib, ... }: {
  programs.noctalia.settings = {
    shell.niri_overview_type_to_launch_enabled = true;
    plugins = {
      enabled = [
        "kenn/keybind-cheatsheet"
      ];
    };
  };

  wayland.windowManager.niri = {
    settings = {
      _children = [
        # Start noctalia on niri startup
        {
          spawn-at-startup = "noctalia";
        }
        # Floating Noctalia settings window
        {
          window-rule = {
            match._props = {
              app-id = "dev.noctalia.Noctalia";
            };
            open-floating = true;
            default-column-width = {
              fixed = 1080;
            };
            default-window-height = {
              fixed = 920;
            };
          };
        }
        # Allows notification actions and window activation from Noctalia
        {
          debug = {
            honor-xdg-activation-with-invalid-serial = { };
          };
        }
        # Display a blurred background for the overview
        {
          layer-rule = {
            match._props = {
              namespace = "^noctalia-backdrop";
            };
            place-within-backdrop = true;
          };
        }
      ];

      # Keybinds
      binds = {
        "Mod+F1" = lib.mkForce {
          _props.hotkey-overlay-title = "Open Keybind Cheatsheet";
          spawn-sh = "noctalia msg panel-toggle kenn/keybind-cheatsheet:cheatsheet";
        };
        "Mod+X" = {
          _props.hotkey-overlay-title = "Open Power Menu";
          spawn-sh = "noctalia msg panel-toggle session";
        };
        "Mod+Space" = {
          _props.hotkey-overlay-title = "Open Launcher";
          spawn-sh = "noctalia msg panel-toggle launcher";
        };
        "Mod+Alt+Comma" = {
          _props.hotkey-overlay-title = "Open Settings";
          spawn-sh = "noctalia msg settings-toggle";
        };
        "Mod+Alt+L" = {
          _props.hotkey-overlay-title = "Lock Screen";
          spawn-sh = "noctalia msg session lock";
        };
        # Volume
        "XF86AudioRaiseVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg volume-up";
        };
        "XF86AudioLowerVolume" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg volume-down";
        };
        "XF86AudioMute" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg volume-mute";
        };
        "XF86AudioMicMute" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg mic-volume-mute";
        };
        # Media control
        "XF86AudioPlay" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg media toggle";
        };
        "XF86AudioPrev" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg media previous";
        };
        "XF86AudioNext" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg media next";
        };
        # Brightness
        "XF86MonBrightnessUp" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg brightness-up";
        };
        "XF86MonBrightnessDown" = {
          _props.allow-when-locked = true;
          spawn-sh = "noctalia msg brightness-down";
        };
      };
    };
  };
}

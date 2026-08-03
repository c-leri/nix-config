{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    pwvucontrol # Volume control gui
    wl-mirror # Mirror screen
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      shell = {
        niri_overview_type_to_launch_enabled = true;
        launch_apps_as_systemd_services = true;
        polkit_agent = true;
      };
      backdrop.enabled = true;
      # Get location from ip
      location.auto_locate = true;
      # Control external monitor brightness
      brightness.enable_ddcutil = true;
      # Bar
      bar.default = {
        start = [
          "workspaces"
          "sysmon"
          "active_window"
          "audio_visualizer"
        ];
        center = [ "clock" ];
        end = [
          "keyboard_layout"
          "tray"
          "elijaharch/wl-screen-mirror:mirror"
          "notifications"
          "volume"
          "brightness"
          "battery"
          "control-center"
        ];
      };
      # Dock
      dock = {
        enabled = true;
        active_monitor_only = true;
        smart_auto_hide = true;
        reserve_space = false;
        show_dots = true;
      };
      # Control center shortcuts
      control_center.shortcuts = [
        { type = "wifi"; }
        { type = "bluetooth"; }
        { type = "clipboard"; }
        { type = "power_profile"; }
        { type = "caffeine"; }
        { type = "nightlight"; }
      ];
      # Night light
      nightlight = {
        enabled = true;
        temperature_night = 5500;
      };
      # Plugins
      plugins = {
        source = [
          {
            enabled = true;
            name = "official";
            kind = "git";
            location = "https://github.com/noctalia-dev/noctalia-plugins";
          }
          {
            enabled = true;
            name = "community";
            kind = "git";
            location = "https://github.com/noctalia-dev/community-plugins";
          }
        ];
        enabled = [
          "kenn/keybind-cheatsheet"
          "elijaharch/wl-screen-mirror"
          "whyoolw/sharednd"
        ];
      };
    };
  };

  wayland.windowManager.niri = {
    settings = {
      _children = [
        # Rounded window corners
        {
          window-rule = {
            geometry-corner-radius = 20;
            clip-to-geometry = true;
          };
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
        # Include monique generated output config
        {
          include = {
            _props.optional = true;
            _args = [ "monitors.kdl" ];
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

{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  noctaliaCall =
    cmd:
    [
      "noctalia-shell"
      "ipc"
      "call"
    ]
    ++ (lib.splitString " " cmd);
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    fastfetch # Display system informations in settings
    pwvucontrol # Volume control gui
    wl-mirror # Mirror screen
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      hooks.enabled = true;
      wallpaper = {
        # Enable wallpaper in overview
        overviewEnabled = true;
        transitionType = [ "fade" ];
      };
      # Get location from ip
      location.autoLocate = true;
      # Control external monitor brightness
      brightness.enableDdcSupport = true;
      # Translucent widgets in noctalia panels
      ui.translucentWidgets = true;
      network.bluetoothHideUnnamedDevices = true;
      general.showHibernateOnLockScreen = true;
      # Bar
      bar = {
        mouseWheelAction = "workspace";
        middleClickAction = "settings";
        widgets = {
          left = [
            { id = "Workspace"; }
            { id = "SystemMonitor"; }
            { id = "ActiveWindow"; }
            {
              id = "MediaMini";
              showArtistFirst = false;
              showVisualizer = true;
              compactMode = true;
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm - dd MMMM";
              tooltipFormat = "dddd d MMMM yyyy, HH:mm";
            }
          ];
          right = [
            { id = "plugin:usb-drive-manager"; }
            {
              id = "KeyboardLayout";
              displayMode = "forceOpen";
            }
            {
              id = "Tray";
              drawerEnabled = false;
            }
            { id = "plugin:mirror-mirror"; }
            { id = "plugin:monique"; }
            { id = "NotificationHistory"; }
            {
              id = "Volume";
              displayMode = "alwaysShow";
            }
            {
              id = "Brightness";
              displayMode = "alwaysShow";
            }
            { id = "plugin:privacy-indicator"; }
            {
              id = "Battery";
              displayMode = "graphic";
            }
            { id = "ControlCenter"; }
          ];
        };
      };
      # Dock
      dock = {
        pinnedStatic = true;
        groupApps = true;
        # Workaround for https://github.com/noctalia-dev/noctalia-shell/issues/2559
        onlySameOutput = false;
      };
      # Launcher
      appLauncher = {
        enableClipboardHistory = true;
        terminalCommand = "xdg-terminal-exec --";
      };
      # Control center shortcuts
      controlCenter.shortcuts = {
        left = [
          { id = "Network"; }
          { id = "Bluetooth"; }
          { id = "AirplaneMode"; }
        ];
        right = [
          { id = "PowerProfile"; }
          { id = "KeepAwake"; }
          { id = "NightLight"; }
        ];
      };
      # Power menu options
      sessionMenu.powerOptions = [
        {
          action = "lock";
          enabled = true;
          keybind = "1";
        }
        {
          action = "logout";
          enabled = true;
          keybind = "2";
        }
        {
          action = "shutdown";
          enabled = true;
          keybind = "3";
        }
        {
          action = "reboot";
          enabled = true;
          keybind = "4";
        }
        {
          action = "rebootToUefi";
          enabled = true;
          keybind = "5";
        }
        {
          action = "suspend";
          enabled = false;
        }
        {
          action = "hibernate";
          enabled = false;
        }
        {
          action = "userspaceReboot";
          enabled = false;
        }
      ];
      # Night light
      nightLight = {
        enable = true;
        nightTemp = "5500";
      };
    };
    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        keybind-cheatsheet = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        mirror-mirror = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        monique = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        polkit-agent = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        usb-drive-manager = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };
    pluginSettings = {
      monique = {
        activeColor = "none";
      };
      privacy-indicator = {
        hideInactive = true;
      };
      usb-drive-manager = {
        hideWhenEmpty = true;
        fileBrowser = "nautilus";
        terminalCommand = "xdg-terminal-exec";
      };
    };
  };

  wayland.windowManager.niri = {
    settings = {
      _children = [
        # Start noctalia with niri
        { spawn-at-startup = "noctalia-shell"; }
        # Recommanded niri settings for noctalia
        {
          window-rule = {
            geometry-corner-radius = [
              20.
              20.
              20.
              20.
            ];
            clip-to-geometry = true;
          };
          debug = {
            honor-xdg-activation-with-invalid-serial = { };
          };
        }
        # Display a blurred background for the overview
        {
          layer-rule = {
            match._props = {
              namespace = "^noctalia-overview*";
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
          spawn = noctaliaCall "plugin:keybind-cheatsheet toggle";
        };
        "Mod+X" = {
          _props.hotkey-overlay-title = "Open Power Menu";
          spawn = noctaliaCall "sessionMenu toggle";
        };
        "Mod+Space" = {
          _props.hotkey-overlay-title = "Open Launcher";
          spawn = noctaliaCall "launcher toggle";
        };
        "Mod+Alt+Comma" = {
          _props.hotkey-overlay-title = "Open Settings";
          spawn = noctaliaCall "settings toggle";
        };
        "Mod+Alt+L" = {
          _props.hotkey-overlay-title = "Lock Screen";
          spawn = noctaliaCall "lockScreen lock";
        };
        # Volume
        "XF86AudioRaiseVolume" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "volume increase";
        };
        "XF86AudioLowerVolume" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "volume decrease";
        };
        "XF86AudioMute" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "volume muteOutput";
        };
        "XF86AudioMicMute" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "volume muteInput";
        };
        # Media control
        "XF86AudioPlay" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "media playPause";
        };
        "XF86AudioPrev" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "media previous";
        };
        "XF86AudioNext" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "media next";
        };
        # Brightness
        "XF86MonBrightnessUp" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "brightness increase";
        };
        "XF86MonBrightnessDown" = {
          _props.allow-when-locked = true;
          spawn = noctaliaCall "brightness decrease";
        };
      };
    };
  };
}

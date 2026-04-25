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
      # Startup apps (megasync, keepassxc, mullvad-vpn)
      hooks = {
        enabled = true;
        startup = "${lib.getExe pkgs.megasync} & ${lib.getExe pkgs.keepassxc} & ${lib.getExe pkgs.mullvad-vpn} &";
      };
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
      # Bar
      bar = {
        mouseWheelAction = "workspace";
        middleClickAction = "settings";
        widgets = {
          left = [
            { id = "Launcher"; }
            {
              id = "Clock";
              formatHorizontal = "ddd dd/MM, HH:mm";
              tooltipFormat = "dddd d MMMM yyyy, HH:mm";
            }
            { id = "SystemMonitor"; }
            { id = "ActiveWindow"; }
            { id = "MediaMini"; }
          ];
          center = [
            { id = "Workspace"; }
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
        # Transparent dock
        backgroundOpacity = lib.mkForce 0.5;
        deadOpacity = 0.5;
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
          { id = "Notifications"; }
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
          action = "suspend";
          enabled = true;
          keybind = "2";
        }
        {
          action = "reboot";
          enabled = true;
          keybind = "3";
        }
        {
          action = "logout";
          enabled = true;
          keybind = "4";
        }
        {
          action = "shutdown";
          enabled = true;
          keybind = "5";
        }
        {
          action = "rebootToUefi";
          enabled = true;
          keybind = "6";
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

  programs.niri = {
    settings = {
      # Start noctalia with niri
      spawn-at-startup = [
        {
          command = [ "noctalia-shell" ];
        }
      ];

      # Recommanded niri settings for noctalia
      window-rules = [
        {
          geometry-corner-radius = {
            bottom-left = 20.;
            bottom-right = 20.;
            top-left = 20.;
            top-right = 20.;
          };
          clip-to-geometry = true;
        }
      ];
      debug = {
        honor-xdg-activation-with-invalid-serial = { };
      };

      # Display a blurred background for the overview
      layer-rules = [
        {
          matches = [
            {
              namespace = "^noctalia-overview*";
            }
          ];
          place-within-backdrop = true;
        }
      ];

      # Keybinds
      binds = {
        "Mod+F1" = lib.mkForce {
          hotkey-overlay.title = "Open Keybind Cheatsheet";
          action.spawn = noctaliaCall "plugin:keybind-cheatsheet toggle";
        };
        "Mod+X" = {
          hotkey-overlay.title = "Open Power Menu";
          action.spawn = noctaliaCall "sessionMenu toggle";
        };
        "Mod+Space" = {
          hotkey-overlay.title = "Open Launcher";
          action.spawn = noctaliaCall "launcher toggle";
        };
        "Mod+Alt+Comma" = {
          hotkey-overlay.title = "Open Settings";
          action.spawn = noctaliaCall "settings toggle";
        };
        "Mod+Alt+L" = {
          hotkey-overlay.title = "Lock Screen";
          action.spawn = noctaliaCall "lockScreen lock";
        };
        # Volume
        "XF86AudioRaiseVolume" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "volume increase";
        };
        "XF86AudioLowerVolume" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "volume decrease";
        };
        "XF86AudioMute" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "volume muteOutput";
        };
        "XF86AudioMicMute" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "volume muteInput";
        };
        # Media control
        "XF86AudioPlay" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "media playPause";
        };
        "XF86AudioPrev" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "media previous";
        };
        "XF86AudioNext" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "media next";
        };
        # Brightness
        "XF86MonBrightnessUp" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "brightness increase";
        };
        "XF86MonBrightnessDown" = {
          allow-when-locked = true;
          action.spawn = noctaliaCall "brightness decrease";
        };
      };
    };
  };
}

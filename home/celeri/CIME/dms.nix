{
  programs.dank-material-shell = {
    session = {
      # Apps pinned to the dock
      pinnedApps = [
        "zen-beta"
        "org.gnome.Nautilus"
        "com.mitchellh.ghostty"
        "steam"
        "itch"
        "vesktop"
        "Cider"
      ];
    };

    settings = {
      # Default bar
      barConfigs = [
        {
          id = "default";
          enabled = true;
          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [
            "music"
            "clock"
            "weather"
          ];
          rightWidgets = [
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "keyboard_layout_name";
              enabled = true;
              keyboardLayoutNameCompactMode = false;
            }
            {
              id = "clipboard";
              enabled = true;
            }
            {
              id = "cpuUsage";
              enabled = true;
              minimumWidth = true;
            }
            {
              id = "memUsage";
              enabled = true;
              minimumWidth = true;
              showSwap = false;
            }
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "privacyIndicator";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
              showAudioPercent = true;
            }
          ];
        }
      ];

      # Display profile to either use the main monitor or the tv
      displayProfiles.niri = {
        "profile_monitor" = {
          id = "profile_monitor";
          name = "Écran PC";
          outputSet = [
            "DP-2"
            "HDMI-A-1"
          ];
        };
        "profile_tv" = {
          id = "profile_tv";
          name = "TV";
          outputSet = [
            "DP-2"
            "HDMI-A-1"
          ];
        };
      };

      activeDisplayProfile.niri = "profile_monitor";
    };
  };

  xdg.configFile."niri/dms/profiles/profile_monitor.kdl".text = ''
    output "HDMI-A-1" {
        off
        scale 1
        position x=0 y=0
    }

    output "DP-2" {
        mode "2560x1440@170.001"
        scale 1
        position x=0 y=0
        variable-refresh-rate on-demand=true
    }
  '';

  xdg.configFile."niri/dms/profiles/profile_tv.kdl".text = ''
    output "DP-2" {
        off
        scale 1
        position x=0 y=0
    }

    output "HDMI-A-1" {
        mode "4096x2160@120.000"
        scale 1.75
        position x=0 y=0
        variable-refresh-rate on-demand=true
    }
  '';
}

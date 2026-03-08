{
  programs.dank-material-shell = {
    session = {
      # Apps pinned to the dock
      pinnedApps = [
        "zen-beta"
        "org.gnome.Nautilus"
        "com.mitchellh.ghostty"
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
              id = "cpuTemp";
              enabled = true;
              minimumWidth = true;
            }
            {
              id = "cpuUsage";
              enabled = true;
              minimumWidth = true;
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
              id = "battery";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
            }
          ];
        }
      ];
    };
  };
}

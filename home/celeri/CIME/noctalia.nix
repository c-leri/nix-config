{
  programs.noctalia-shell = {
    settings = {
      # Dock pinned apps
      dock.pinnedApps = [
        "zen-beta"
        "org.gnome.Nautilus"
        "com.mitchellh.ghostty"
        "steam"
        "itch"
        "vesktop"
        "Cider"
      ];
    };
    pluginSettings = {
      # Custom commands to turn the TV and monitor on/off
      custom-commands = {
        commands = [
          {
            name = "Monitor On";
            command = "niri msg output 'DP-2' on";
            icon = "device-desktop";
          }
          {
            name = "Monitor Off";
            command = "niri msg output 'DP-2' off";
            icon = "device-desktop-off";
          }
          {
            name = "TV On";
            command = "niri msg output 'HDMI-A-1' on";
            icon = "device-tv";
          }
          {
            name = "TV Off";
            command = "niri msg output 'HDMI-A-1' off";
            icon = "device-tv-off";
          }
        ];
      };
    };
  };
}

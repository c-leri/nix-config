{ lib, ... }:
{
  programs.noctalia-shell = {
    settings = {
      dock = {
        # Dock pinned apps
        pinnedApps = [
          "zen-beta"
          "org.gnome.Nautilus"
          "com.mitchellh.ghostty"
          "steam"
          "itch"
          "vesktop"
          "Cider"
        ];
        # Transparent dock
        backgroundOpacity = lib.mkForce 0.5;
        deadOpacity = 0.5;
      };
      # Get GPU temp
      systemMonitor.enableDgpuMonitoring = true;
    };
  };
}

{ lib, pkgs, ... }:
{
  programs.noctalia-shell = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn, steam)
      hooks.startup = "${lib.getExe pkgs.megasync} & ${lib.getExe pkgs.keepassxc} & ${lib.getExe pkgs.mullvad-vpn} & ${lib.getExe pkgs.steam} -silent &";
      dock = {
        # Dock pinned apps
        pinnedApps = [
          "zen-beta"
          "org.gnome.Nautilus"
          "com.mitchellh.ghostty"
          "steam"
          "net.lutris.Lutris"
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

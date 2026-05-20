{ lib, pkgs, ... }:
{
  programs.noctalia-shell = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn)
      hooks.startup = "${lib.getExe pkgs.megasync} & ${lib.getExe pkgs.keepassxc} & ${lib.getExe pkgs.mullvad-vpn} &";
      # Dock pinned apps
      dock.pinnedApps = [
        "zen-beta"
        "org.gnome.Nautilus"
        "com.mitchellh.ghostty"
        "vesktop"
        "Cider"
      ];
    };
  };
}

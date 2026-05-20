{
  programs.noctalia-shell = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn)
      hooks.startup = "megasync & keepassxc & mullvad-vpn &";
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

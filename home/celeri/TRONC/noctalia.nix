{
  programs.noctalia-shell = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn)
      hooks.started = "megasync & keepassxc & mullvad-vpn &";
      # Dock pinned apps
      dock.pinned = [
        "zen-beta"
        "nautilus"
        "ghostty"
        "vesktop"
        "cider"
      ];
    };
  };
}

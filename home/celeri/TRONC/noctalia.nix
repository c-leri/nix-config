{ config, lib, ... }: {
  programs.noctalia = {
    settings = {
      # Startup apps (megasync, keepassxc, mullvad-vpn)
      # Sleep a bit before launching the apps because the hook is executed before the tray is ready
      hooks.started = "(sleep 3 && (megasync & keepassxc & mullvad-vpn)) &";
      # Dock pinned apps
      dock.pinned = [
        "zen-beta"
        "org.gnome.Nautilus"
        "com.mitchellh.ghostty"
        "vesktop"
        "cider-2"
      ];
      # Wallpaper
      wallpaper.default.path = lib.mkForce "${config.programs.noctalia.settings.wallpaper.directory}/TRONC.jpg";
    };
  };
}

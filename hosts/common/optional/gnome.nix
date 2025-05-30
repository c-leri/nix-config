{
  pkgs,
  lib,
  ...
}: {
  services = {
    xserver = {
      # Enable the X11 windowing system.
      enable = true;

      # Disable xterm
      excludePackages = [pkgs.xterm];

      # Enable the GDM Display Manager
      displayManager.gdm.enable = true;

      # Enable the GNOME Desktop Environment.
      desktopManager.gnome.enable = true;
    };

    # Disable keyring
    gnome.gnome-keyring.enable = lib.mkForce false;
  };

  # Disable some gnome core apps
  environment.gnome.excludePackages = with pkgs; [
    epiphany
    geary
    gnome-backgrounds
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-color-manager
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    gnome-text-editor
    gnome-tour
    simple-scan
    snapshot
    totem
    yelp
  ];
}

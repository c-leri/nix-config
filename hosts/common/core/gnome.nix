{pkgs, ...}: {
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Disable xterm
    excludePackages = [pkgs.xterm];

    # Enable the GNOME Desktop Environment.
    desktopManager.gnome.enable = true;
  };

  # Disable some gnome core apps
  environment.gnome.excludePackages = with pkgs;
  with gnome; [
    epiphany
    geary
    gnome-backgrounds
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
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

{pkgs, ...}: {
  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;

    # Disable xterm
    excludePackages = [pkgs.xterm];

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Disable some gnome core apps
  environment.gnome.excludePackages = with pkgs;
  with gnome; [
    epiphany
    geary
    gnome-calculator
    gnome-characters
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-text-editor
    gnome-tour
    simple-scan
    snapshot
    totem
    yelp
  ];
}

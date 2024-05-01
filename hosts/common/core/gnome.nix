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
  environment.gnome.excludePackages = with pkgs.gnome; [
    pkgs.gnome-tour
    epiphany
    pkgs.gnome-text-editor
    gnome-calculator
    gnome-characters
    pkgs.gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    pkgs.gnome-connections
    simple-scan
    pkgs.snapshot
    totem
    yelp
    geary
  ];
}

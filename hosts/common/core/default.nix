{pkgs, ...}: {
  imports = [
    # Nixpkgs config
    ../../../nixpkgs.nix

    # Nix config
    ./nix.nix

    # Auto-upgrade service
    ./services/auto-upgrade.nix
  ];

  boot = {
    # Latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    bootspec.enable = true;
  };

  # Enable zram
  zramSwap.enable = true;

  # Sudo password stars hint
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "fr_FR.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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

  # Disable xterm
  services.xserver.excludePackages = [pkgs.xterm];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    unstable.helix
    wl-clipboard

    git
    zip
    unzip
  ];

  # Install CaskaydiaCove Nerd Font
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaCode"];})
  ];

  hardware.enableRedistributableFirmware = true;
}

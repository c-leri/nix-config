{pkgs, ...}: {
  imports = [
    # Nixpkgs config
    ../../../nixpkgs.nix

    # Nix config
    ./nix.nix

    # Nix helper config
    ./nh.nix

    # Sops config
    ./sops.nix

    # Auto-upgrade service
    ./services/auto-upgrade.nix

    # Settings
    ./sddm.nix
    ./pipewire.nix
  ];

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.enableRedistributableFirmware = true;

  # Set the time zone
  time.timeZone = "America/Toronto";

  # Set the locale
  i18n.defaultLocale = "fr_FR.UTF-8";

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    helix
    wl-clipboard

    git
    zip
    unzip
  ];

  # Install CaskaydiaCove Nerd Font
  fonts.packages = with pkgs; [(nerdfonts.override {fonts = ["CascadiaCode"];})];

  # Enable zram
  zramSwap.enable = true;

  # Sudo password stars hint
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;
}

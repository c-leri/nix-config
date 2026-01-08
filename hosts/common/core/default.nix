{ pkgs, ... }:
{
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

    # Languages
    ./languages/default.nix

    # Theme
    ./theme.nix

    # Settings
    ./pipewire.nix
  ];

  # Set the time zone
  time.timeZone = "Europe/Paris";

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

  # Enable zram
  zramSwap.enable = true;

  # Increase bootloader timeout
  boot.loader.timeout = 30;

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

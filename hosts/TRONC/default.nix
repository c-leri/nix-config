{
  inputs,
  config,
  lib,
  ...
}: {
  imports = [
    # Harware modules
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    # Required
    ./hardware-configuration.nix
    ../common/core

    # Optional
    ../common/optional/mullvad-vpn.nix
    ../common/optional/docker.nix
    ../common/optional/hyprland.nix

    # User
    ../common/users/celeri.nix

    # Host specific
    ./power-management.nix
    ./shared-partition.nix
  ];

  networking.hostName = "TRONC";

  boot = {
    # Bootloader
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "fr";
    xkbVariant = "";
  };

  # Configure console keymap
  console.keyMap = "fr";

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = config.users.users.celeri.name;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

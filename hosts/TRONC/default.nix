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
    ../common/optional/searx.nix

    # User
    ../common/users/celeri.nix

    # Host specific
    ./keymap.nix
    ./auto-login.nix
    ./power-management.nix
    ./shared-partition.nix
  ];

  networking.hostName = "TRONC";

  # Set the sops key
  sops.age.keyFile = "/home/${config.users.users.celeri.name}/.config/sops/age/keys.txt";

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

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}

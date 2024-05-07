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
    inputs.hardware.nixosModules.common-pc-laptop

    # Required
    ./hardware-configuration.nix
    ../common/core

    # Optional
    ../common/optional/gnome.nix
    ../common/optional/hyprland.nix
    ../common/optional/mullvad-vpn.nix
    ../common/optional/docker.nix
    ../common/optional/flatpak.nix

    # User
    ../common/users/celeri.nix

    # Host specific
    ./power-management
    ./keymap.nix
    ./auto-login.nix
    ./shared-partition.nix
    ./searx.nix
  ];

  networking.hostName = "TRONC";

  # Set the nixos and home-manager config flake for nh
  programs.nh.flake = "/home/${config.users.users.celeri.name}/nix-config";

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

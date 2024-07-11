{
  inputs,
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    # Harware modules
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-nvidia-nonprime
    inputs.hardware.nixosModules.common-pc-ssd

    # Required
    ./hardware-configuration.nix
    ../common/core

    # Optional
    ../common/optional/gnome.nix
    ../common/optional/mullvad-vpn.nix
    ../common/optional/docker.nix
    ../common/optional/flatpak.nix
    ../common/optional/steam.nix

    # User
    ../common/users/celeri.nix

    # Host specific
    ./auto-login.nix
    ./data-disk.nix
    ./keymap.nix
    ./nvidia.nix
    ./openrgb.nix
  ];

  networking.hostName = "CIME";

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  hardware.enableRedistributableFirmware = true;

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
  system.stateVersion = "24.05";
}

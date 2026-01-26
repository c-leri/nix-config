{
  inputs,
  pkgs,
  config,
  ...
}:
{
  imports = [
    # Harware modules
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # Required
    ./hardware-configuration.nix
    ../common/core

    # Optional
    ../common/optional/gnome.nix
    ../common/optional/mullvad-vpn.nix
    ../common/optional/docker.nix
    ../common/optional/flatpak.nix
    ../common/optional/games

    # User
    ../common/users/celeri.nix

    # Theming
    ./theme.nix

    # Host specific
    ./amdgpu.nix
    ./auto-login.nix
    ./data-disk.nix
    ./keymap.nix
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
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        secureBoot.enable = true;
        extraEntries = ''
          /Windows
            protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}

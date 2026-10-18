{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  nix.settings = {
    substituters = [ "https://noctalia.cachix.org" ];
    trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
  };

  imports = [
    inputs.noctalia.nixosModules.default
  ];

  programs.noctalia = {
    enable = true;
    recommendedServices.enable = true;
  };

  environment.systemPackages = with pkgs; [
    baobab # Disk usage gui
    ddcutil # Get and update external monitors brightness
    file-roller # Archive viewer
    gnome-disk-utility # Disk format gui
    mission-center # System monitor gui
    nautilus # File explorer
    ristretto # Image viewer
    udiskie # Usb drive automounter
  ];

  # Net top tool, wrapped to be runnable without root (used by mission-center)
  security.wrappers."nethogs" = {
    source = lib.getExe pkgs.nethogs;
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe";
  };

  # Allow wheel users to check CPU power draw (used by mission-center)
  services.udev.extraRules = ''
    SUBSYSTEM=="powercap", KERNEL=="intel-rapl*", \
        RUN+="${lib.getExe' pkgs.coreutils "chgrp"} -R wheel /sys/%p/'", \
        RUN+="${lib.getExe' pkgs.coreutils "chmod"} -R g+r /sys/%p/"
  '';

  # Service allowing applications to interract with storage devices (used by udiskie)
  services.udisks2.enable = true;

  # Allows MTP file transfer
  services.gvfs.enable = true;

  # Tumbnail service for ristretto
  services.tumbler.enable = true;
}

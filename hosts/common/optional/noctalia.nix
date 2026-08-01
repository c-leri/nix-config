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

  imports = [ inputs.monique.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    mission-center # System monitor gui
  ];

  # Allows noctalia to switch power profile
  services.power-profiles-daemon.enable = true;

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

  # Monitors management gui
  programs.monique.enable = true;
}

{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.monique.nixosModules.default ];

  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    mission-center # System monitor gui
  ];

  # Net top tool, wrapped to be runnable without root (used by mission-center)
  security.wrappers."nethogs" = {
    source = lib.getExe pkgs.nethogs;
    owner = "root";
    group = "root";
    capabilities = "cap_net_admin,cap_net_raw,cap_dac_read_search,cap_sys_ptrace+pe";
  };

  # Monitors management gui
  programs.monique.enable = true;
}

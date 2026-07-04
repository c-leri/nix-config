{ inputs, ... }:
{
  imports = [ inputs.jovian.nixosModules.jovian ];

  jovian = {
    steam.enable = true;

    steamos = {
      useSteamOSConfig = false;

      enableAutoMountUdevRules = true;
      enableBluetoothConfig = true;
      enableSysctlConfig = true;
    };

    hardware.has.amd.gpu = true;
  };
}

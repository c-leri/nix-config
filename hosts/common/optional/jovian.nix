{ inputs, ... }:
{
  imports = [ inputs.jovian.nixosModules.jovian ];

  jovian = {
    steam.enable = true;

    steamos.useSteamOSConfig = false;

    hardware.has.amd.gpu = true;
  };
}

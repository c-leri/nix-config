{
  inputs,
  config,
  lib,
  ...
}:
let
  extraCompatPaths =
    lib.makeSearchPathOutput "steamcompattool" ""
      config.programs.steam.extraCompatPackages;
in
{
  imports = [ inputs.jovian.nixosModules.jovian ];

  jovian = {
    steam = {
      enable = true;
      environment = (
        lib.optionalAttrs (config.programs.steam.extraCompatPackages != [ ]) {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = extraCompatPaths;
        }
      );
    };

    steamos.useSteamOSConfig = false;

    hardware.has.amd.gpu = true;
  };
}

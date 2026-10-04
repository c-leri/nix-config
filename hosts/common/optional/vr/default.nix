{ pkgs, config, ... }:
let
  amdgpu-patched = pkgs.callPackage ./amdgpu-patched.nix {
    kernel = config.boot.kernelPackages.kernel;
  };
in
{
  boot = {
    # Patch amdgpu yo allow any application to create high priority contexts (needed for SteamVR asynchronous reprojection)
    extraModulePackages = [
      amdgpu-patched
    ];

    # Select a country for the wireless regulatory database (allows Steam Frame dongle to use 6GHz)
    extraModprobeConfig = ''
      options cfg80211 ieee80211_regdom=FR
    '';
  };
}

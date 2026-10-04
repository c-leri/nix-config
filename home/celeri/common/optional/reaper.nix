{ inputs, pkgs, ... }: {
  imports = [
    inputs.reaper-flake.homeModules.reaper
  ];

  programs.reaper = {
    enable = true;

    extensions = {
      reapack = {
        enable = true;
        addDefaultRepositories = true;

        installNewPackagesWhenSynchronizing = false;
        enablePrereleasesGlobally = false;
        promptToUninstallObsoletePackages = true;
        browser.expandSynonyms = true;

        network = {
          verifyPeer = true;
          refreshIndexCacheAfterSeconds = 86400;
          fallbackProxy = "ask";
        };

        synchronizeOnActivation = true;
      };
      sws = {
        enable = true;

        colors = [
          "#56B4E9"
          "#E69F00"
          "#009E73"
          "#CC79A7"
          "#0072B2"
          "#D55E00"
          "#F0E442"
          "#999999"
        ];
      };
    };

    theme = {
      active = "Reapertips Theme.ReaperThemeZip";
      colorThemes = [ ];
      packages = [
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reapertips-theme
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.part-theme
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reark-theme
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.imperial-theme
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.xraym-analog-theme
        inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reaclassical-theme
      ];
    };

    swell.colortheme = {
      enable = true;
      preset = inputs.reaper-flake.packages.${pkgs.stdenv.hostPlatform.system}.reapertips-theme;
    };
  };
}

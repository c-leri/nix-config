{ inputs, lib, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.dms-plugin-registry.modules.default
  ];

  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableKeybinds = true;
      enableSpawn = false;
    };

    plugins = {
      emojiLauncher.enable = true;

      developerUtilities = {
        enable = true;

        settings = {
          autoPaste = true;
        };
      };
    };

    settings = {
      # Dock
      showDock = true;
      dockAutoHide = true;
      dockGroupByApp = true;
      dockIsolateDisplay = true;
      dockTransparency = lib.mkForce 0;

      # Weather
      useAutoLocation = true;
    };
  };
}

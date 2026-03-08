{ inputs, lib, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;

    niri = {
      enableKeybinds = true;
      enableSpawn = false;
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

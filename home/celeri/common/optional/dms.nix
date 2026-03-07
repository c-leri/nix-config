{ inputs, lib, ... }:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  programs.dank-material-shell = {
    enable = true;

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

{ lib, pkgs, ... }:
{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };
      custom = {
        start = "${lib.getExe' pkgs.libnotify "notify-send"} -u low -a 'gamemode' 'Gamemode Started'";
        end = "${lib.getExe' pkgs.libnotify "notify-send"} -u low -a 'gamemode' 'Gamemode Ended'";
      };
    };
  };
}

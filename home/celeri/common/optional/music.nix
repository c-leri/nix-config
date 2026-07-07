{ pkgs, ... }: {
  # ReaPack
  xdg.configFile."REAPER/UserPlugins/reaper_reapack-x86_64.so".source =
    "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";

  # SWS
  xdg.configFile."REAPER/UserPlugins/reaper_sws-x86_64.so".source =
    "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
  xdg.configFile."REAPER/Scripts/sws_python.py".source =
    "${pkgs.reaper-sws-extension}/Scripts/sws_python.py";
  xdg.configFile."REAPER/Scripts/sws_python64.py".source =
    "${pkgs.reaper-sws-extension}/Scripts/sws_python64.py";
}

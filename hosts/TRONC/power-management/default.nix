{
  services.power-profiles-daemon.enable = false;
  # Used by dms to query the battery level
  services.upower.enable = true;
  services.thermald = {
    enable = true;
    configFile = ./thermal-conf.xml;
  };
}

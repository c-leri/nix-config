{
  services.power-profiles-daemon.enable = false;
  services.thermald = {
    enable = true;
    configFile = ./thermal-conf.xml;
  };
}

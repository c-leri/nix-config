{
  services.upower.enable = true;
  services.thermald = {
    enable = true;
    configFile = ./thermal-conf.xml;
  };
}

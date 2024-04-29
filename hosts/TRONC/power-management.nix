{
  services.power-profiles-daemon.enable = false;
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "never";
      };
      battery = {
        governor = "powersave";
        turbo = "never";
      };
    };
  };
}

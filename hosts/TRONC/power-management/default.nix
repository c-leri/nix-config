{
  config,
  lib,
  ...
}: {
  services.power-profiles-daemon.enable = false;
  services.thermald = {
    enable = true;
    configFile = ./thermal-conf.xml;
  };
  # Fix for thermald to use the config file
  # see https://github.com/NixOS/nixpkgs/issues/201402
  systemd.services.thermald.serviceConfig.ExecStart = let
    cfg = config.services.thermald;
  in
    lib.mkForce ''
      ${cfg.package}/sbin/thermald \
        --no-daemon \
        ${lib.optionalString cfg.debug "--loglevel=debug"} \
        ${lib.optionalString (cfg.configFile != null) "--config-file ${cfg.configFile}"} \
        --dbus-enable \
        ${lib.optionalString (cfg.configFile == null) "--adaptive"}
    '';
}

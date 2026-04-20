{ config, lib, ... }:
{
  services.greetd = {
    settings = {
      # Auto-login into niri
      initial_session = {
        command = lib.getExe config.programs.niri.package;
        user = config.users.users.celeri.name;
      };
    };
  };
}

{
  inputs,
  config,
  pkgs,
  ...
}:
{
  services.displayManager.dms-greeter = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
    compositor.name = "niri";
    configHome = "/home/${config.users.users.celeri.name}";
  };

  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.dsearch.enable = true;
}

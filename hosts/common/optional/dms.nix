{
  inputs,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    # Include a file explorer
    nautilus
    # XWayland support
    xwayland-satellite
  ];

  programs.niri.enable = true;

  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/${config.users.users.celeri.name}";
  };

  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.dsearch.enable = true;
}

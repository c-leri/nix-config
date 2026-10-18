{ inputs, pkgs, ... }:
{
  imports = [
    inputs.monique.nixosModules.default
  ];

  environment.systemPackages = with pkgs; [
    # XWayland support
    xwayland-satellite
  ];

  environment.sessionVariables = {
    # Support dead keys in GTK4 applications
    GTK_IM_MODULE = "simple";
    # Tell electron apps to use wayland directly instead of rellying on xwayland
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  programs.niri.enable = true;

  # Monitors management gui
  programs.monique.enable = true;
}

{ pkgs, ... }:
{
  nix.settings = {
    substituters = [ "https://niri.cachix.org" ];
    trusted-public-keys = [ "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964=" ];
  };

  environment.systemPackages = with pkgs; [
    # Disk format gui
    gnome-disk-utility
    # File explorer
    nautilus
    # Image viewer
    ristretto
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

  # Allows MTP file transfer
  services.gvfs.enable = true;

  # Tumbnail service for ristretto
  services.tumbler.enable = true;
}

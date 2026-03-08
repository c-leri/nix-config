{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Include a file explorer
    nautilus
    # Image viewer
    ristretto
    # XWayland support
    xwayland-satellite
  ];

  programs.niri.enable = true;

  # Allows MTP file transfer
  services.gvfs.enable = true;

  # Tumbnail service for ristretto
  services.tumbler.enable = true;
}

{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    catppuccin.enable = true;
    package = pkgs.rofi-wayland;
  };
}

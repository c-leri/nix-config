{
  inputs,
  pkgs,
  ...
}: {
  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs.hyprland.enable = true;

  programs.light.enable = true;
  programs.evince.enable = true;
  programs.file-roller.enable = true;
  programs.gnome-disks.enable = true;

  environment.systemPackages = with pkgs; [
    gnome.nautilus
    baobab
    loupe
  ];
}

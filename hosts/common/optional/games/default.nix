{pkgs, ...}: {
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    ankama-launcher
    prismlauncher
  ];
}

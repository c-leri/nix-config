{ pkgs, ... }:
{
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    prismlauncher
    unstable.shadps4
  ];
}

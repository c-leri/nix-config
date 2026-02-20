{ pkgs, ... }:
{
  imports = [
    ./steam.nix
  ];

  environment.systemPackages = with pkgs; [
    itch
    prismlauncher
    r2modman
    unstable.shadps4
  ];
}

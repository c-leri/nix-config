{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Polkit agent
  security.soteria.enable = true;
}

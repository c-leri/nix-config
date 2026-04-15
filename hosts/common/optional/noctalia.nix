{ inputs, pkgs, ... }:
{
  imports = [ inputs.monique.nixosModules.default ];

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.monique.enable = true;
}

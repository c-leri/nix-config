{ inputs, pkgs, ... }:
{
  programs.dms-shell = {
    enable = true;
    package = inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };

  programs.dsearch.enable = true;
}

{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
    inputs.jovian.overlays.default
  ];

  programs.steam.package = lib.mkForce (
    pkgs.millennium-steam.override {
      steam = pkgs.jovianPackages.steam;
    }
  );
}

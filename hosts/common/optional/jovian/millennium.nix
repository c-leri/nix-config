{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];

  programs.steam.package = lib.mkForce (
    inputs.jovian.legacyPackages.${pkgs.stdenv.hostPlatform.system}.steam.override {
      steam' = pkgs.millennium-steam;
    }
  );
}

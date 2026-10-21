{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [ inputs.millennium.overlays.default ];

  programs.steam.package = lib.mkDefault pkgs.millenium-steam;
}

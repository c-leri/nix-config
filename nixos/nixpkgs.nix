{ inputs, outputs, ... }:
{
  nixpkgs = {
    overlays = [
      inputs.rust-overlay.overlays.default
      outputs.overlays.unstable-pkgs
      outputs.overlays."22_11-pkgs"
    ];
    config = import ../nixpkgs-config.nix;
  };
}

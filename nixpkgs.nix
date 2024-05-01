{
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.rust-overlay.overlays.default
      outputs.overlays."22_11-pkgs"
    ];
    config = {
      allowUnfree = true;
    };
  };
}

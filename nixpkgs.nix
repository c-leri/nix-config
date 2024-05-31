{
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.rust-overlay.overlays.default
      outputs.overlays.unstable-pkgs
    ];
    config = {
      allowUnfree = true;
    };
  };
}

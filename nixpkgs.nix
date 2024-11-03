{
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.rust-overlay.overlays.default
      outputs.overlays.stable-pkgs
      outputs.overlays.zen-browser
    ];
    config = {
      allowUnfree = true;
    };
  };
}

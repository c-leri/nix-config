{
  inputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      inputs.niri.overlays.niri
    ];
    config = {
      allowUnfree = true;
    };
  };
}

{
  outputs,
  ...
}:
{
  nixpkgs = {
    overlays = [
      outputs.overlays.zen-browser
    ];
    config = {
      allowUnfree = true;
    };
  };
}

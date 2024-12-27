{
  inputs,
  outputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.rust-overlay.overlays.default
      outputs.overlays.zen-browser
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "dotnet-runtime-6.0.36"
        "dotnet-sdk-6.0.428"
      ];
    };
  };
}

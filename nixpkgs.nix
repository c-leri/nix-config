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
      permittedInsecurePackages = [
        "dotnet-runtime-6.0.36"
        "dotnet-sdk-6.0.428"
        "dotnet-sdk-wrapped-6.0.428"
        "dotnet-sdk-7.0.410"
        "dotnet-sdk-wrapped-7.0.410"
      ];
    };
  };
}

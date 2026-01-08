{ inputs, ... }:
{
  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.stdenv.hostPlatform.system;

      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "dotnet-runtime-6.0.36"
          "dotnet-sdk-6.0.428"
        ];
      };
    };
  };

  zen-browser = final: _prev: {
    zen-browser = inputs.zen-browser.packages.${final.stdenv.hostPlatform.system}.default;
  };
}

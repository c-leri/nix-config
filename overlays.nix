{inputs, ...}: rec {
  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;

      overlays = [
        shadps4-0_9
      ];

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
    zen-browser = inputs.zen-browser.packages.${final.system}.default;
  };

  # Manually update shadps4 to v0.8.0
  shadps4-0_9 = final: prev: {
    shadps4 = prev.shadps4.overrideAttrs (finalAttrs: _previousAttrs: {
      version = "0.9.0";

      src = final.fetchFromGitHub {
        owner = "shadps4-emu";
        repo = "shadPS4";
        tag = "v.${finalAttrs.version}";
        hash = "sha256-ljnoClmijCds/ydqXaRuUL6/Qv/fGIkLyGsmfPDqvVo=";
        fetchSubmodules = true;
      };
    });
  };
}

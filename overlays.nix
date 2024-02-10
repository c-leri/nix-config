{ inputs, ... }:
{
  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = import ./nixpkgs-config.nix;
    };
  };

  "22_11-pkgs" = final: _prev: {
    "22_11" = import inputs.nixpkgs-22_11 {
      system = final.system;
      config = import ./nixpkgs-config.nix;
    };
  };
}

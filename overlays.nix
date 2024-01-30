{ inputs, ... }:
{
  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config = import ./nixpkgs-config.nix;
    };
  };
}

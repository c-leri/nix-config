{
  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  # Flake outputs
  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      perSystem = {pkgs, ...}: {
        # Format this file with `nix fmt`
        formatter = pkgs.alejandra;

        # Checks run with `nix flake check`
        checks = {};

        # Packages built with `nix build`
        packages = {};

        # Development shell entered with `nix develop`
        devShells.default = pkgs.mkShell {};
      };
    };
}

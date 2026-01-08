{
  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-root.url = "github:srid/flake-root";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Flake outputs
  outputs =
    inputs@{
      flake-parts,
      flake-root,
      treefmt-nix,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        flake-root.flakeModule
        treefmt-nix.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem =
        {
          pkgs,
          config,
          lib,
          ...
        }:
        let
          name = "PROJECT_NAME";
        in
        {
          # Format the whole project with `nix fmt`
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;

            # To format nix files
            programs.nixfmt.enable = true;
          };

          # Checks run with `nix flake check`
          checks = { };

          # Packages built with `nix build`
          packages = { };

          # Development shell entered with `nix develop`
          devShells.default = pkgs.mkShell {
            inherit name;

            # Export $FLAKE_ROOT in the development shell
            inputsFrom = [ config.flake-root.devShell ];

            # Provide treefmt's formaters in the development shell
            packages = lib.attrValues config.treefmt.build.programs;
          };
        };
    };
}

{
  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          system,
          pkgs,
          config,
          lib,
          ...
        }:
        let
          name = "PROJECT_NAME";

          # Custom rust toolchain from the `rust-toolchain.toml` file
          rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;

          # Executables build dependencies
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];

          # Libraries build dependecies
          buildInputs = with pkgs; [
            cairo
            dbus
            gdk-pixbuf
            glib
            gtk3
            librsvg
            libsoup_3
            openssl
            webkitgtk_4_1
          ];
        in
        {
          # Override the `pkgs` attribute
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              # Adds a `rust-bin` attibute to pkgs
              # that allows installing a rust toolchain
              # from a `rust-toolchain.toml` file
              (import inputs.rust-overlay)
            ];
          };

          # Format the whole project with `nix fmt`
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;

            # To format nix files
            programs.nixfmt.enable = true;

            # To format rust files
            programs.rustfmt.enable = true;

            # To format toml files
            programs.taplo.enable = true;

            # To format json/js/ts/html/css
            programs.prettier.enable = true;

            settings = {
              excludes = [
                # Images
                "*.png"
                "*.svg"
                "*.ico"
                "*.icns"

                # Lock files
                "*.lock"
                "*.lockb"
                "*-lock.json"

                # Git
                ".gitignore"
                "**/.gitignore"
              ];
            };
          };

          # Development shell with all needed dependencies
          # entered with `nix develop`
          devShells.default = pkgs.mkShell {
            inherit name nativeBuildInputs buildInputs;

            # Export $FLAKE_ROOT in the development shell
            inputsFrom = [ config.flake-root.devShell ];

            # Provide treefmt's formaters in the development shell
            packages =
              lib.attrValues config.treefmt.build.programs
              ++ (with pkgs; [
                rustToolchain
                cargo-tauri
                nodejs_20
                corepack_20
              ]);

            shellHook = ''
              # Environment variable to tell the system where to find the libraries
              export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${lib.makeLibraryPath buildInputs}"
            '';
          };
        };
    };
}

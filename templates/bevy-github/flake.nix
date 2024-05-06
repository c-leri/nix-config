{
  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    crane = {
      url = "github:ipetkov/crane";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
  outputs = inputs @ {
    flake-parts,
    flake-root,
    treefmt-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        flake-root.flakeModule
        treefmt-nix.flakeModule
      ];

      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];

      perSystem = {
        system,
        self',
        pkgs,
        config,
        lib,
        ...
      }: let
        # Custom rust toolchain from the `rust-toolchain.toml` file
        rustToolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
        craneLib = (inputs.crane.mkLib pkgs).overrideToolchain rustToolchain;

        # Get the name and version of the rust crate
        crateMeta = craneLib.crateNameFromCargoToml {cargoToml = ./Cargo.toml;};

        # Filter to keep the assets folder
        assetsFilter = path: _type: lib.hasInfix "/assets/" path != null;

        commonArgs = {
          src = lib.cleanSourceWith {
            src = craneLib.path ./.;
            filter = path: type: (assetsFilter path type) || (craneLib.filterCargoSources path type);
          };
          strictDeps = true;

          # Executables needed by bevy
          nativeBuildInputs = [pkgs.pkg-config];

          # Libraries needed by bevy
          buildInputs = with pkgs; [
            alsa-lib
            udev
            xorg.libX11
            xorg.libXrandr
            xorg.libXcursor
            xorg.libXi
            wayland
          ];
        };

        # Build just the cargo dependencies
        cargoArtifacts = craneLib.buildDepsOnly commonArgs;

        # Build the rust crate itself
        PROJECT_NAME = craneLib.buildPackage (
          commonArgs
          // {
            inherit cargoArtifacts;

            postInstall = ''
              # Copy the assets to the built output folder
              cp -r assets/ $out/bin/
            '';
          }
        );

        # Libraries needed at runtime
        runtimeDependencies = with pkgs; [
          libxkbcommon
          vulkan-loader
        ];
      in {
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
          programs.alejandra.enable = true;

          # To format rust files
          programs.rustfmt.enable = true;

          # To format toml files
          programs.taplo.enable = true;
        };

        # Checks run with `nix flake check`
        checks = {
          # Check that the project builds
          # and the tests pass
          inherit PROJECT_NAME;

          # Check that the doc builds without warnings
          PROJECT_NAME-doc = craneLib.cargoDoc (
            commonArgs
            // {
              inherit cargoArtifacts;
              cargoDocExtraArgs = "--no-deps --document-private-items";
              RUSTDOCFLAGS = "--deny warnings";
            }
          );
        };

        # Packages built with `nix build`
        packages = {
          # Build the unwrapped package by default
          default = PROJECT_NAME;

          # Wrap the built crate with it runtime dependencies
          # (for usage with nix only)
          wrapped = pkgs.symlinkJoin {
            name = "${crateMeta.pname}-wrapped-${crateMeta.version}";
            paths = [PROJECT_NAME];
            buildInputs = [pkgs.makeWrapper];
            postBuild = ''
              # Wrap the executable with an environment variable
              # that tells the system where to fin the runtime dependencies libs
              wrapProgram $out/bin/${crateMeta.pname} \
                --suffix LD_LIBRARY_PATH : "${lib.makeLibraryPath runtimeDependencies}"
            '';
          };

          # Build the crate's documentation
          doc = craneLib.cargoDoc (
            commonArgs
            // {
              inherit cargoArtifacts;
              cargoDocExtraArgs = "--document-private-items";
            }
          );
        };

        # Application run with `nix run`
        apps.default = {
          type = "app";
          # Run the wrapped package by default
          program = "${self'.packages.PROJECT_NAME-wrapped}/bin/${crateMeta.pname}";
        };

        # Development shell with all needed dependencies
        # entered with `nix develop`
        devShells.default = craneLib.devShell {
          # Inherit inputs from checks
          checks = self'.checks;

          name = crateMeta.pname;

          # Export $FLAKE_ROOT in the development shell
          inputsFrom = [config.flake-root.devShell];

          # Provide treefmt's formaters in the development shell
          packages = lib.attrValues config.treefmt.build.programs;

          shellHook = ''
            # Environment variable to tell the system where to find the libraries
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
              lib.makeLibraryPath (runtimeDependencies ++ commonArgs.buildInputs)
            }"
          '';
        };
      };
    };
}

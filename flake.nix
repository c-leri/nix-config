{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    nixpkgs,
    lanzaboote,
    sops-nix,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;

    systems = ["x86_64-linux"];
    forAllSystem = nixpkgs.lib.genAttrs systems;
  in {
    formatter = forAllSystem (system: nixpkgs.legacyPackages.${system}.alejandra);

    devShell = forAllSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in
        pkgs.mkShell {
          name = "nix-config";
          packages = with pkgs; [
            age
            sops
          ];
        }
    );

    overlays = import ./overlays.nix {inherit inputs;};

    nixosConfigurations = {
      TRONC = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/TRONC
          lanzaboote.nixosModules.lanzaboote
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "hmbak";
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
      CIME = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/CIME
          lanzaboote.nixosModules.lanzaboote
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              backupFileExtension = "hmbak";
              useUserPackages = true;
              useGlobalPkgs = true;
              extraSpecialArgs = {
                inherit inputs;
              };
            };
          }
        ];
      };
    };

    templates = {
      basic-flake = {
        path = ./templates/basic-flake;
        description = "A basic empty flake";
        welcomeText = ''
          Remember to replace `PROJECT_NAME` in `flake.nix` with the name of your project!
        '';
      };

      rust = {
        path = ./templates/rust;
        description = "A flake for rust development";
        welcomeText = ''
          Remember to replace all instances of `PROJECT_NAME` in `Cargo.toml` and `flake.nix` with the name of your project!
        '';
      };

      rust-github = {
        path = ./templates/rust-github;
        description = "A flake for rust development with Github Actions for building the project and building and deploying the project's documentation as a Github Page";
        welcomeText = ''
          Remember to replace all instances of `PROJECT_NAME` in `Cargo.toml`, `flake.nix` and `.github/workflows/build.yml` with the name of your project!
        '';
      };

      bevy = {
        path = ./templates/bevy;
        description = "A flake for bevy development";
        welcomeText = ''
          Remember to replace all instances of `PROJECT_NAME` in `Cargo.toml` and `flake.nix` with the name of your project!
        '';
      };

      bevy-github = {
        path = ./templates/bevy-github;
        description = "A flake for bevy development with Github Actions for building the project and building and deploying the project's documentation as a Github Page";
        welcomeText = ''
          Remember to replace all instances of `PROJECT_NAME` in `Cargo.toml`, `flake.nix` and `.github/workflows/build.yml` with the name of your project!
        '';
      };
    };
  };
}

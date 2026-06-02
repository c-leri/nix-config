{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hardware.url = "github:nixos/nixos-hardware";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      # Temp fix for https://github.com/nix-community/stylix/issues/2334
      url = "github:nix-community/stylix/pull/2337/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    monique = {
      url = "github:ToRvaLDz/monique";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    steam-presence = {
      url = "github:JustTemmie/steam-presence";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    jovian = {
      url = "github:Jovian-Experiments/Jovian-NixOS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nixcord.url = "github:FlameFlag/nixcord";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      treefmt-nix,
      sops-nix,
      home-manager,
      stylix,
      ...
    }:
    let
      inherit (self) outputs;

      systems = [ "x86_64-linux" ];
      forAllSystem = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
      treefmtEval = forAllSystem (pkgs: treefmt-nix.lib.evalModule pkgs ./treefmt.nix);
    in
    {
      formatter = forAllSystem (
        pkgs: treefmtEval.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper
      );

      devShell = forAllSystem (
        pkgs:
        pkgs.mkShell {
          name = "nix-config";
          packages = with pkgs; [
            age
            sops
          ];
        }
      );

      nixosConfigurations = {
        TRONC = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/TRONC
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix

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
            sops-nix.nixosModules.sops
            stylix.nixosModules.stylix

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
    };
}

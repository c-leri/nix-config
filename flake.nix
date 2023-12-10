{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, lanzaboote, rust-overlay, home-manager, ... }:
    {
      nixosConfigurations = {
        TRONC-Linux = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./nixos/configuration.nix
            lanzaboote.nixosModules.lanzaboote
            ({ nixpkgs.overlays = [ rust-overlay.overlays.default ]; })
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                useGlobalPkgs = true;
                users.celeri = ./home-manager/home.nix;
              };
            }
          ];
        };
      };
    };
}

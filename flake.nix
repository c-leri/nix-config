{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    lanzaboote.url = "github:nix-community/lanzaboote";
    rust-overlay.url = "github:oxalica/rust-overlay";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, lanzaboote, rust-overlay, home-manager }:
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

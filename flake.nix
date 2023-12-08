{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/23.11";
    lanzaboote.url = "github:nix-community/lanzaboote";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, lanzaboote, home-manager, ... }:
  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations = {
      TRONC-Linux = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./nixos/configuration.nix
          lanzaboote.nixosModules.lanzaboote
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

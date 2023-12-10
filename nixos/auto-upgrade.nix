{
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = "/home/celeri/nixos-config";
    flags = [
      "--update-input" "nixpkgs"
      "--update-input" "lanzaboote"
      "--update-input" "rust-overlay"
      "--update-input" "home-manager"
      "-L"
    ];
    dates = "daily";
  };
}

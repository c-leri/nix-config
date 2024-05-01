{
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = "/home/celeri/nix-config";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "hardware"
      "--update-input"
      "lanzaboote"
      "--update-input"
      "home-manager"
      "--update-input"
      "rust-overlay"
      "--update-input"
      "catppuccin"
      "--update-input"
      "spicetify-nix"
      "-L"
    ];
    dates = "daily";
  };
}

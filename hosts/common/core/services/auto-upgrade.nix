{
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = "/home/celeri/nix-config";
    flags = [
      "--update-input"
      "nixpkgs"
      "--update-input"
      "nixpkgs-unstable"
      "--update-input"
      "hardware"
      "--update-input"
      "lanzaboote"
      "--update-input"
      "sops-nix"
      "--update-input"
      "home-manager"
      "--update-input"
      "hyprland"
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

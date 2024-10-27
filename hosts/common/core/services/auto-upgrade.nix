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
      "sops-nix"
      "--update-input"
      "home-manager"
      "--update-input"
      "catppuccin"
      "--update-input"
      "rust-overlay"
      "--update-input"
      "zen-browser"
      "-L"
    ];
    dates = "daily";
  };
}

{inputs, ...}: {
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = inputs.self.outPath;
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
      "stylix"
      "--update-input"
      "rust-overlay"
      "--update-input"
      "zen-browser"
      "-L"
    ];
    dates = "daily";
  };
}

{
  imports = [
    # Required
    ../common/core

    # Optional
    ../common/optional/umbriel.nix
    ../common/optional/noctalia
    ../common/optional/noctalia/umbriel.nix
    ../common/optional/noctalia-greeter.nix
    ../common/optional/reaper.nix
    ../common/optional/godot.nix
    ../common/optional/steamvr.nix

    # Host specific
    ./umbriel.nix
    ./noctalia.nix
  ];

  home.stateVersion = "24.05";
}

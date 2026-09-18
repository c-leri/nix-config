{
  imports = [
    # Required
    ../common/core

    # Optional
    ../common/optional/niri.nix
    ../common/optional/noctalia.nix
    ../common/optional/music.nix
    ../common/optional/godot.nix
    ../common/optional/steamvr.nix

    # Host specific
    ./niri.nix
    ./noctalia.nix
  ];

  home.stateVersion = "24.05";
}

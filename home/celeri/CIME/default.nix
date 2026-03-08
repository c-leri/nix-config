{
  imports = [
    # Required
    ../common/core

    # Optional
    ../common/optional/niri.nix
    ../common/optional/dms.nix

    # Host specific
    ./niri.nix
    ./dms.nix
  ];

  home.stateVersion = "24.05";
}

{
  imports = [
    # Required
    ../common/core

    # Optional
    ../common/optional/niri.nix
    ../common/optional/dms.nix
    ../common/optional/mullvad-vpn.nix

    # Host specific
    ./dms.nix
  ];

  home.stateVersion = "24.05";
}

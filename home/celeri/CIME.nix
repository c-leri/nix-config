{
  imports = [
    # Required
    common/core

    # Optional
    common/optional/gnome
    common/optional/mullvad-vpn.nix
  ];

  home.stateVersion = "24.05";
}

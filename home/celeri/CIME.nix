{
  imports = [
    # Required
    common/core

    # Optional
    common/optional/gnome
    common/optional/lazydocker.nix
    common/optional/mullvad-vpn.nix
    common/optional/prismlauncher.nix
  ];

  home.stateVersion = "24.05";
}

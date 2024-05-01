{
  imports = [
    # Required
    common/core

    # Optional
    common/optional/lazydocker.nix
    common/optional/mullvad-vpn.nix
    common/optional/prismlauncher.nix
    # common/optional/hyprland
  ];

  home.username = "celeri";
  home.homeDirectory = "/home/celeri";
  home.stateVersion = "23.11";
}

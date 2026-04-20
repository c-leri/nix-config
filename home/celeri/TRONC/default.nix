{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    # Required
    ../common/core

    # Optional
    ../common/optional/niri.nix
    ../common/optional/noctalia.nix

    # Host specific
    ./noctalia.nix
  ];

  home.stateVersion = "23.11";

  # Change icons folder color to better suit the theme
  stylix.icons.package = lib.mkForce (pkgs.papirus-icon-theme.override { color = "darkcyan"; });
}

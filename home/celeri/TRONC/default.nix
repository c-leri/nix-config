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
    ../common/optional/dms.nix

    # Host specific
    ./dms.nix
  ];

  home.stateVersion = "23.11";

  # Change icons folder color to better suit the theme
  stylix.icons.package = lib.mkForce (pkgs.papirus-icon-theme.override { color = "darkcyan"; });
}

{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # Required
    common/core

    # Optional
    common/optional/gnome
    common/optional/mullvad-vpn.nix
    # common/optional/rider.nix
  ];

  home.stateVersion = "23.11";

  # Change icons folder color to better suit the theme
  stylix.icons.package = lib.mkForce (pkgs.papirus-icon-theme.override {color = "darkcyan";});

  # Change taskbar focused indicator to better suit the theme
  dconf.settings."org/gnome/shell/extensions/aztaskbar".indicator-color-focused = "rgb(33,144,164)";
}

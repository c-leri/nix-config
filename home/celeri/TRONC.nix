{pkgs, ...}: {
  imports = [
    # Required
    common/core

    # Optional
    common/optional/gnome
    common/optional/mullvad-vpn.nix
    common/optional/rider.nix
  ];

  home.stateVersion = "23.11";

  # Change icons folder color to better suit the theme
  stylix.iconTheme.package = pkgs.papirus-icon-theme.override {color = "cyan";};

  # Change taskbar focused indicator to better suit the theme
  dconf.settings."org/gnome/shell/extensions/aztaskbar".indicator-color-focused = "rgb(33,144,164)";
}

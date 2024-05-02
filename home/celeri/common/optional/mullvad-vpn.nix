{pkgs, ...}: {
  home.packages = [pkgs.mullvad-vpn];

  xdg.configFile."autostart/mullvad-vpn.desktop".source = "${pkgs.mullvad-vpn}/share/applications/mullvad-vpn.desktop";
}

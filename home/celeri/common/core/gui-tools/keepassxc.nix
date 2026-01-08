{ pkgs, ... }:
{
  home.packages = [ pkgs.keepassxc ];

  xdg.configFile."autostart/org.keepassxc.KeePassXC.desktop".source =
    "${pkgs.keepassxc}/share/applications/org.keepassxc.KeePassXC.desktop";
}

{ pkgs, ... }:
{
  home.packages = [
    pkgs.megasync
  ];

  xdg.configFile."autostart/megasync.desktop".source =
    "${pkgs.megasync}/share/applications/megasync.desktop";
}

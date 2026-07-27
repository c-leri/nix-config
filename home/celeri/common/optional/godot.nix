{ pkgs, ... }: {
  home.packages = with pkgs; [
    godotPackages_4_7.godot
  ];

  xdg.dataFile."godot/export_templates".source =
    "${pkgs.godotPackages_4_7.export-templates-bin}/share/godot/export_templates";
}

{pkgs, ...}: {
  # Set ghostty as default terminal
  home.packages = [pkgs.xdg-terminal-exec];
  xdg.configFile."xdg-terminal.list".text = "com.mitchellh.ghostty.desktop";
  xdg.dataFile."applications/com.mitchellh.ghostty.desktop".source = "${pkgs.ghostty}/share/applications/com.mitchellh.ghostty.desktop";

  programs.ghostty.enable = true;
}

{
  programs.ghostty.enable = true;

  # Set ghostty as default terminal
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "com.mitchellh.ghostty.desktop"
      ];
    };
  };
}

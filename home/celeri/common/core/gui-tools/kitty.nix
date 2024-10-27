{pkgs, ...}: {
  # Set kitty as default terminal
  home.packages = [pkgs.xdg-terminal-exec];
  xdg.configFile."xdg-terminal.list".text = "kitty.desktop";
  xdg.dataFile."applications/kitty.desktop".source = "${pkgs.kitty}/share/applications/kitty.desktop";

  programs.kitty = {
    enable = true;
    catppuccin.enable = true;
    font = {
      name = "CaskaydiaCove Nerd Font";
      size = 12;
    };

    settings = {
      allow_remote_control = "socket-only";
      listen_on = "unix:@kitty";

      enabled_layouts = "splits,stack";
    };
  };
}

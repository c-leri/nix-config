{
  programs.gnome-terminal = {
    enable = true;
    profile = {
      "5083e06b-024e-46be-9cd2-892b814f1fc8" = {
        visibleName = "Catppuccin Macchiato";
        default = true;
        audibleBell = true;
        font = "CaskaydiaCove Nerd Font 12";
        colors = {
          backgroundColor = "#24273a";
          foregroundColor = "#cad3f5";
          cursor = {
            background = "#f4dbd6";
            foreground = "#24273a";
          };
          highlight = {
            background = "#24273a";
            foreground = "#5b6078";
          };
          palette = [
            "#494d64" "#ed8796" "#a6da95" "#eed49f"
            "#8aadf4" "#f5bde6" "#8bd5ca" "#b8c0e0"
            "#5b6078" "#ed8796" "#a6da95" "#eed49f"
            "#8aadf4" "#f5bde6" "#8bd5ca" "#a5adcb"
          ];
        };
        transparencyPercent = 50;
      } ;
    };
  };
}

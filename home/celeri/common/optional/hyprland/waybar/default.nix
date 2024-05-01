{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";
        modules-left = ["hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = [
          "tray"
          "pulseaudio"
          "battery"
          "clock"
        ];

        "hyprland/window".format = "{}";

        "hyprland/workspaces" = {
          disable-scroll = true;
          sort-by-name = true;
          format = "{icon}";
          format-icons = {
            default = "";
          };
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "󰝟";
          format-icons = [
            "󰕿"
            "󰖀"
            "󰕾"
          ];
          tooltip = true;
          tooltip-format = "{volume}%";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-charging = " {icon}";
          format-plugged = " {icon}";
          format-icons = [
            "󰂎"
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip = true;
          tooltip-format = "{capacity}%";
        };

        clock = {
          format = "{:%H:%M}";
          tooltip = true;
          tooltip-format = "{:%c}";
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };
      }
    ];
    style = builtins.readFile ./style.css;
  };
}

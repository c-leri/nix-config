{ pkgs, ... }:
{
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-macchiato";
      ui = {
        pane_frames = {
          hide_session_name = true;
        };
      };
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      # Bounds alacritty to a zellij session
      env = {
        ZELLIJ_AUTO_ATTACH = "true";
        ZELLIJ_AUTO_EXIT = "true";
      };
      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [
          "--init-command"
          "eval (zellij setup --generate-auto-start fish | string collect)"
        ];
      };

      font.normal.family = "CaskaydiaCove Nerd Font";

      # catppuccin macchiato theme
      colors = {
        primary = {
          background = "#24273A";
          foreground = "#CAD3F5";
          dim_foreground = "#CAD3F5";
          bright_foreground = "#CAD3F5";
        };
        cursor = {
          text = "#24273A";
          cursor = "#F4DBD6";
        };
        vi_mode_cursor = {
          text = "#24273A";
          cursor = "#B7BDF8";
        };
        search = {
          matches = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };
          focused_match = {
            foreground = "#24273A";
            background = "#A6DA95";
          };
        };
        hints = {
          start = {
            foreground = "#24273A";
            background = "#EED49F";
          };
          end = {
            foreground = "#24273A";
            background = "#A5ADCB";
          };
        };
        selection = {
          text = "#24273A";
          background = "#F4DBD6";
        };
        normal = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };
        bright = {
          black = "#5B6078";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#A5ADCB";
        };
        dim = {
          black = "#494D64";
          red = "#ED8796";
          green = "#A6DA95";
          yellow = "#EED49F";
          blue = "#8AADF4";
          magenta = "#F5BDE6";
          cyan = "#8BD5CA";
          white = "#B8C0E0";
        };
        indexed_colors = [
          { index = 16; color = "#F5A97F"; }
          { index = 17; color = "#F4DBD6"; }
        ];
      };
    };
  };
}

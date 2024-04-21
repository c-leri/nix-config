{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require "wezterm"

      function get_color_scheme()
        if wezterm.gui.get_appearance():find "Dark" then
          return "Catppuccin Macchiato"
        else
          return "Catppuccin Latte"
        end
      end
    
      return {
        color_scheme = get_color_scheme(),
        font = wezterm.font("CaskaydiaCove Nerd Font"),

        hide_tab_bar_if_only_one_tab = true,
        hide_mouse_cursor_when_typing = false,

        command_palette_bg_color = "#1e1e2e",
        command_palette_fg_color = "#cdd6f4",
      }
    '';
  };
}

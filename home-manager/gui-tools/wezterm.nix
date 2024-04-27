{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = pkgs.unstable.wezterm;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Macchiato",
        font = wezterm.font("CaskaydiaCove Nerd Font"),

        hide_tab_bar_if_only_one_tab = true,
        hide_mouse_cursor_when_typing = false,

        command_palette_bg_color = "#1e1e2e",
        command_palette_fg_color = "#cdd6f4",
      }
    '';
  };
}

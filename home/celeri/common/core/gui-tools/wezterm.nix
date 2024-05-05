{
  pkgs,
  config,
  lib,
  ...
}: let
  catppuccinFlavour = config.catppuccin.flavour;
  capitalizedCatppuccinFlavour = (lib.toUpper (builtins.substring 0 1 catppuccinFlavour)) + (builtins.substring 1 (builtins.stringLength catppuccinFlavour) catppuccinFlavour);
in {
  # Set wezterm as the default terminal
  home.packages = [pkgs.xdg-terminal-exec];
  xdg.configFile."xdg-terminals.list".text = "org.wezfurlong.wezterm.desktop";
  xdg.dataFile."xdg-terminals/org.wezfurlong.wezterm.desktop".source = "${pkgs.wezterm}/share/applications/org.wezfurlong.wezterm.desktop";

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin ${capitalizedCatppuccinFlavour}",
        font = wezterm.font("CaskaydiaCove Nerd Font"),

        hide_tab_bar_if_only_one_tab = true,
        hide_mouse_cursor_when_typing = false,

        command_palette_bg_color = "#1e1e2e",
        command_palette_fg_color = "#cdd6f4",
      }
    '';
  };
}

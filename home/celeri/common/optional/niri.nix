{
  inputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [ inputs.niri.homeModules.niri ];

  xdg.configFile."niri/config.kdl".text = ''
    // Nix generated config
    include "nix-generated-config.kdl"

    // Monique generated output config
    include optional=true "monitors.kdl"
  '';
  xdg.configFile.niri-config.target = lib.mkForce "niri/nix-generated-config.kdl";

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    settings = {
      # Hide window decoration
      prefer-no-csd = true;
      input.keyboard.numlock = true;
      hotkey-overlay.skip-at-startup = true;
      layout = {
        default-column-width.proportion = 0.5;
      };
      binds = {
        "Mod+Shift+Slash" = {
          action.show-hotkey-overlay = { };
        };
        "Mod+D" = {
          repeat = false;
          action.toggle-overview = { };
        };
        "Mod+Q" = {
          repeat = false;
          action.close-window = { };
        };
        "Mod+Shift+E" = {
          action.quit = { };
        };
        "Ctrl+Shift+space" = {
          hotkey-overlay.title = "Switch keyboard layout";
          action.switch-layout = "next";
        };
        # Open default terminal
        "Mod+T" = {
          action.spawn = [ "xdg-terminal-exec" ];
        };
        # Maximize/fullscreen window/column
        "Mod+F" = {
          action.maximize-column = { };
        };
        "Mod+Shift+F" = {
          action.fullscreen-window = { };
        };
        "Mod+Ctrl+F" = {
          action.expand-column-to-available-width = { };
        };
        "Mod+M" = {
          action.maximize-window-to-edges = { };
        };
        # Move focus in workspace
        "Mod+Left" = {
          action.focus-column-left = { };
        };
        "Mod+Down" = {
          action.focus-window-down = { };
        };
        "Mod+Up" = {
          action.focus-window-up = { };
        };
        "Mod+Right" = {
          action.focus-column-right = { };
        };
        # Move windows/columns in workspace
        "Mod+Ctrl+Left" = {
          action.move-column-left = { };
        };
        "Mod+Ctrl+Down" = {
          action.move-window-down = { };
        };
        "Mod+Ctrl+Up" = {
          action.move-window-up = { };
        };
        "Mod+Ctrl+Right" = {
          action.move-column-right = { };
        };
        # Move focus accross workspaces
        "Mod+Page_Down" = {
          action.focus-workspace-down = { };
        };
        "Mod+Page_Up" = {
          action.focus-workspace-up = { };
        };
        # Move windows/columns accross workspaces
        "Mod+Ctrl+Page_Down" = {
          action.move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+Page_Up" = {
          action.move-column-to-workspace-up = { };
        };
        "Mod+Shift+Page_Down" = {
          action.move-workspace-down = { };
        };
        "Mod+Shift+Page_Up" = {
          action.move-workspace-up = { };
        };
        # Scroll focus
        "Mod+WheelScrollDown" = {
          cooldown-ms = 150;
          action.focus-workspace-down = { };
        };
        "Mod+WheelScrollUp" = {
          cooldown-ms = 150;
          action.focus-workspace-up = { };
        };
        "Mod+WheelScrollRight" = {
          action.focus-column-right = { };
        };
        "Mod+WheelScrollLeft" = {
          action.focus-column-left = { };
        };
        "Mod+Shift+WheelScrollDown" = {
          action.focus-column-right = { };
        };
        "Mod+Shift+WheelScrollUp" = {
          action.focus-column-left = { };
        };
        # Scroll columns
        "Mod+Ctrl+WheelScrollDown" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-down = { };
        };
        "Mod+Ctrl+WheelScrollUp" = {
          cooldown-ms = 150;
          action.move-column-to-workspace-up = { };
        };
        "Mod+Ctrl+WheelScrollRight" = {
          action.move-column-right = { };
        };
        "Mod+Ctrl+WheelScrollLeft" = {
          action.move-column-left = { };
        };
        "Mod+Ctrl+Shift+WheelScrollDown" = {
          action.move-column-right = { };
        };
        "Mod+Ctrl+Shift+WheelScrollUp" = {
          action.move-column-left = { };
        };
        # Move focus to specific workspace
        "Mod+1" = {
          action.focus-workspace = 1;
        };
        "Mod+2" = {
          action.focus-workspace = 2;
        };
        "Mod+3" = {
          action.focus-workspace = 3;
        };
        "Mod+4" = {
          action.focus-workspace = 4;
        };
        "Mod+5" = {
          action.focus-workspace = 5;
        };
        "Mod+6" = {
          action.focus-workspace = 6;
        };
        "Mod+7" = {
          action.focus-workspace = 7;
        };
        "Mod+8" = {
          action.focus-workspace = 8;
        };
        "Mod+9" = {
          action.focus-workspace = 9;
        };
        # Move column to specific workspace
        "Mod+Ctrl+1" = {
          action.move-column-to-workspace = 1;
        };
        "Mod+Ctrl+2" = {
          action.move-column-to-workspace = 2;
        };
        "Mod+Ctrl+3" = {
          action.move-column-to-workspace = 3;
        };
        "Mod+Ctrl+4" = {
          action.move-column-to-workspace = 4;
        };
        "Mod+Ctrl+5" = {
          action.move-column-to-workspace = 5;
        };
        "Mod+Ctrl+6" = {
          action.move-column-to-workspace = 6;
        };
        "Mod+Ctrl+7" = {
          action.move-column-to-workspace = 7;
        };
        "Mod+Ctrl+8" = {
          action.move-column-to-workspace = 8;
        };
        "Mod+Ctrl+9" = {
          action.move-column-to-workspace = 9;
        };
        # Move window left/right
        "Mod+BracketLeft" = {
          action.consume-or-expel-window-left = { };
        };
        "Mod+BracketRight" = {
          action.consume-or-expel-window-right = { };
        };
        # Floating windows
        "Mod+V" = {
          action.toggle-window-floating = { };
        };
        "Mod+Shift+V" = {
          action.switch-focus-between-floating-and-tiling = { };
        };
        # Screenshot
        "Print" = {
          action.screenshot = { };
        };
        "Ctrl+Print" = {
          action.screenshot-screen = { };
        };
        "Alt+Print" = {
          action.screenshot-window = { };
        };
      };
    };
  };
}

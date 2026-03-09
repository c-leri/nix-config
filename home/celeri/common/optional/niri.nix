{ inputs, pkgs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      # Hide window decoration
      prefer-no-csd = true;
      input.keyboard.numlock = true;
      hotkey-overlay.skip-at-startup = true;
      layout = {
        default-column-width.proportion = 0.5;
      };
      binds = {
        "Ctrl+Shift+space" = {
          hotkey-overlay.title = "Switch keyboard layout";
          action.switch-layout = "next";
        };
        "Mod+Alt+F" = {
          action.maximize-window-to-edges = { };
        };
      };
    };
  };
}

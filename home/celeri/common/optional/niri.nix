{ inputs, pkgs, ... }:
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      layout = {
        default-column-width.proportion = 0.5;
      };
      hotkey-overlay.skip-at-startup = true;
      input.keyboard.numlock = true;
    };
  };
}

{ inputs, pkgs, ... }: {
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  environment.systemPackages = with pkgs; [
    # DAW
    reaper
    # Fonts for REAPER
    fira-sans
    roboto
    # Windows plugins bridge
    yabridge
    yabridgectl
    # Plugins
    vital
    x42-avldrums
  ];

  musnix.enable = true;

  services.pipewire.jack.enable = true;
}

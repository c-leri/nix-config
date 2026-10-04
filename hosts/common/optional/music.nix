{ inputs, pkgs, ... }: {
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  environment.systemPackages = with pkgs; [
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

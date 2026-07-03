{ inputs, pkgs, ... }: {
  imports = [
    inputs.musnix.nixosModules.musnix
  ];

  environment.systemPackages = with pkgs; [
    reaper
    yabridge
    yabridgectl
  ];

  musnix.enable = true;

  services.pipewire.jack.enable = true;
}

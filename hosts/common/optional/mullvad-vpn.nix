{ pkgs, ... }:
{
  # Enable mullvad vpn
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
    enableExcludeWrapper = false;
  };
}

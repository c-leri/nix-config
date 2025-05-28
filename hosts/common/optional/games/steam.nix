{
  programs.steam = {
    enable = true;
    extest.enable = true;

    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
  };
}

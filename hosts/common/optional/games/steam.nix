{
  programs.steam = {
    enable = true;
    extest.enable = true;

    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;
  programs.gamescope.enable = true;
}

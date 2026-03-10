{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.steam-presence.nixosModules.steam-presence ];

  sops.secrets.steam_api_key = {
    sopsFile = ../../../../secrets/hosts/common/steam_api_key;
    format = "binary";
    owner = config.users.users.celeri.name;
  };

  environment.systemPackages = with pkgs; [
    gamescope-wsi
  ];

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam = {
    enable = true;
    extest.enable = true;
    gamescopeSession = {
      enable = true;
      args = [
        "--adaptive-sync"
        "--hdr-enabled"
        "--hdr-debug-force-output"
      ];
    };

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;

    presence = {
      enable = true;
      steamApiKeyFile = config.sops.secrets.steam_api_key.path;
      userIds = [ "76561198247925496" ];
    };
  };
}

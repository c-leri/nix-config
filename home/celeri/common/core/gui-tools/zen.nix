{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
  };

  stylix.targets.zen-browser.profileNames = [ "default" ];
}

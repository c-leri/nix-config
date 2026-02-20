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
    nativeMessagingHosts = [ pkgs.firefoxpwa ];
    suppressXdgMigrationWarning = true;
  };

  stylix.targets.zen-browser.profileNames = [ "default" ];
}

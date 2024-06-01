{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  sops.secrets.celeri-password = {
    key = "celeri";
    sopsFile = ../../../secrets/hosts/common/passwords.yaml;
    format = "yaml";
    neededForUsers = true;
  };

  programs.zsh = {
    enable = true;
    vteIntegration = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
  };

  users.users.celeri = {
    name = "celeri";
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.celeri-password.path;
    shell = pkgs.zsh;
    extraGroups =
      ["wheel"]
      ++ ifTheyExist [
        "audio"
        "video"
        "docker"
        "networkmanager"
      ];
  };

  # Add user to nix trusted users
  nix.settings.trusted-users = ["celeri"];

  # Load this user's home manager config
  home-manager.users.celeri = import ../../../home/celeri/${config.networking.hostName}.nix;
}

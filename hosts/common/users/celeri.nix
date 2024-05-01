{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = false;
  sops.secrets.celeri-password = {
    key = "password";
    sopsFile = ../../../secrets/celeri.yaml;
    format = "yaml";
    neededForUsers = true;
  };

  programs.fish.enable = true;

  users.users.celeri = {
    name = "celeri";
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.celeri-password.path;
    shell = pkgs.fish;
    extraGroups =
      ["wheel"]
      ++ ifTheyExist [
        "docker"
        "networkmanager"
      ];
  };

  # Add user to nix trusted users
  nix.settings.trusted-users = ["celeri"];

  # Load this user's home manager config
  home-manager.users.celeri = import ../../../home/celeri/${config.networking.hostName}.nix;
}

{
  pkgs,
  config,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  programs.fish.enable = true;

  users.users.celeri = {
    name = "celeri";
    isNormalUser = true;
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

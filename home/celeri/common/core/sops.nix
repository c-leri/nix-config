{
  inputs,
  config,
  ...
}: let
  secretsFolder = ../../../../secrets/users/celeri;
in {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = {
      ssh-private-key = {
        format = "binary";
        sopsFile = "${secretsFolder}/id_ed25519";
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };
}

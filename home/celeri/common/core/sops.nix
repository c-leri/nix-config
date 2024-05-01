{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = ../../../../secrets/celeri.yaml;
    defaultSopsFormat = "yaml";

    secrets = {
      celeri-public-key = {
        key = "public_key";
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
      celeri-private-key = {
        key = "private_key";
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
    };
  };
}

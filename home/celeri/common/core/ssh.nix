{ config, ... }:
let
  ssh-public-key = ../../../../public/users/celeri/id_ed25519.pub;
in
{
  home.file = {
    ssh-public-key = {
      target = ".ssh/id_ed25519.pub";
      source = ssh-public-key;
    };

    ssh-allowed-signers = {
      target = ".ssh/allowed_signers";
      text = ''
        ${config.programs.git.settings.user.email} namespaces="git" ${builtins.readFile ssh-public-key}
      '';
    };
  };

  programs.ssh = {
    enable = true;

    matchBlocks."*" = {
      addKeysToAgent = "yes";
    };
  };
}

{ config, ... }:
let
  secretsFolder = ../../../../secrets/users/celeri;
in
{
  # Github access token
  sops.secrets.github-access-token = {
    sopsFile = "${secretsFolder}/github_access_token";
    format = "binary";
    # Make the github token accessible to nh
    path = "${config.xdg.stateHome}/nh/github-token";
  };

  # Sops template with nix access tokens config
  sops.templates."nix-access-tokens.conf" = {
    content = ''
      access-tokens = github.com=${config.sops.placeholder.github-access-token}
    '';
  };

  nix = {
    extraOptions = "!include ${config.sops.templates."nix-access-tokens.conf".path}";
  };
}

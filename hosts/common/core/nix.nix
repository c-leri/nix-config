{ inputs, config, ... }:
{
  # Github access token
  sops.secrets.github-access-token = {
    sopsFile = ../../../secrets/hosts/common/github_access_token;
    format = "binary";
  };

  # Sops template with nix access tokens config
  sops.templates."nix-access-tokens.conf" = {
    mode = "444"; # Make it readable to everyone
    content = ''
      access-tokens = github.com=${config.sops.placeholder.github-access-token}
    '';
  };

  # Nix settings
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      trusted-users = [ "root" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      substituters = [
        "https://nix-community.cachix.org"
        "https://noctalia.cachix.org"
        "https://niri.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
      ];
    };
    extraOptions = "!include ${config.sops.templates."nix-access-tokens.conf".path}";
  };
}

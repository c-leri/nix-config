{
  imports = [
    ../common/optional/searx.nix
  ];

  # Get the environment file secret
  sops.secrets.searxEnvironmentFile = {
    sopsFile = ../../secrets/hosts/TRONC/searx_environment_file;
    format = "binary";
  };
}

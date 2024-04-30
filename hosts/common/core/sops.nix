let
  secretsFolder = ../../../secrets;
in {
  sops = {
    secrets.searxEnvironmentFile = {
      format = "binary";
      sopsFile = secretsFolder + /searx_environment_file;
    };
  };
}

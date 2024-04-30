{config, ...}: {
  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets.searxEnvironmentFile.path;
    settings = {
      server = {
        port = 5346;
        secret_key = "@SECRET_KEY@";
        image_proxy = true;
      };
      use_default_settings.engines.remove = [
        "google"
        "google images"
        "google news"
        "google videos"
      ];
    };
  };
}

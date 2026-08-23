{
  # Add compression to save a bit of space and optimise ssd lifespan
  fileSystems = {
    "/".options = [ "compress=lzo" ];
    "/home".options = [ "compress=lzo" ];
    "/nix".options = [
      "compress=lzo"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
  };

  # Monthly check and repair corrupted files
  services.btrfs.autoScrub = {
    enable = true;
    interval = "monthly";
    fileSystems = [ "/" ];
  };
}

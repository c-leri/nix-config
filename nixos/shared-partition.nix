{
  boot.supportedFilesystems = [ "ntfs" ];

  # Mount the Shared partition
  fileSystems."/mnt/Shared" = {
    label = "Shared";
    fsType = "ntfs";
  };
}

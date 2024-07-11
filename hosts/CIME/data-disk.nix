{
  boot.supportedFilesystems = ["ntfs"];

  # Mount the Shared partition
  fileSystems."/mnt/Data" = {
    label = "Data";
    fsType = "ntfs";
  };
}

{
  boot.supportedFilesystems = ["ntfs"];

  # Mount the Shared partition
  fileSystems."/media/Data" = {
    label = "Data";
    fsType = "ntfs";
  };
}

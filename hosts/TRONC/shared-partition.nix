{
  boot.supportedFilesystems = ["ntfs"];

  # Mount the Shared partition
  fileSystems."/media/Shared" = {
    label = "Shared";
    fsType = "ntfs";
  };
}

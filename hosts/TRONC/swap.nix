{
  # Add swap file for hibernation
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # 32GB
    }
  ];
}

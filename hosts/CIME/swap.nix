{
  # Add swap file for hibernation
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 32 * 1024; # 32GiB
    }
  ];
}

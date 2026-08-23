{
  # Add swap file for hibernation
  swapDevices = [
    {
      device = "/swap/swapfile";
      size = 16 * 1024; # 16GiB
    }
  ];
}

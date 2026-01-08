{ inputs, ... }:
{
  system.autoUpgrade = {
    enable = true;
    operation = "boot";
    flake = inputs.self.outPath;
    flags = [
      "-L"
    ];
    dates = "daily";
  };
}

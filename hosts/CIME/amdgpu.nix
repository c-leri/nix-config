{
  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];
  };

  hardware.amdgpu = {
    opencl.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };
}

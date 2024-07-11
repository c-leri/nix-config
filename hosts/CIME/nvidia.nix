{config, ...}: {
  hardware = {
    opengl.enable = true;

    nvidia = {
      modesetting.enable = true;

      powerManagement.enable = false;

      open = false;

      nvidiaSettings = false;

      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };
}

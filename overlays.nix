{inputs, ...}: {
  "22_11-pkgs" = final: _prev: {
    "22_11" = import inputs.nixpkgs-22_11 {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}

{inputs, ...}: {
  stable-pkgs = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  zen-browser = final: _prev: {
    zen-browser = {
      specific = inputs.zen-browser.packages.${final.system}.specific;
      generic = inputs.zen-browser.packages.${final.system}.generic;
    };
  };
}

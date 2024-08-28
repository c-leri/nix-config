{inputs, ...}: {
  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };

  zen-browser = final: _prev: {
    zen-browser = {
      specific = inputs.zen-browser.packages."${final.system}".specific;
      generic = inputs.zen-browser.packages."${final.system}".generic;
    };
  };
}

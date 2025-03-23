{inputs, ...}: {
  unstable-pkgs = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;

      config.allowUnfree = true;
    };
  };

  zen-browser = final: _prev: {
    zen-browser = inputs.zen-browser.packages.${final.system}.default;
  };
}

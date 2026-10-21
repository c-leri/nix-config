{ inputs, ... }: {
  imports = [
    inputs.umbriel.nixosModules.default
  ];

  nix.settings = {
    extra-substituters = [ "https://umbriel.cachix.org" ];
    extra-trusted-public-keys = [
      "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
    ];
  };

  environment.sessionVariables = {
    # Support dead keys in GTK4 applications
    GTK_IM_MODULE = "simple";
    # Tell electron apps to use wayland directly instead of rellying on xwayland
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  programs.umbriel.enable = true;

  programs.xwayland.enable = true;

  services.gnome.gnome-keyring.enable = true;
}

{ inputs, ... }: {
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      appearance = {
        hide_logo = true;
      };
    };
  };
}

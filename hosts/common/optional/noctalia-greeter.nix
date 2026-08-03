{ inputs, ... }: {
  imports = [ inputs.noctalia-greeter.nixosModules.default ];

  programs.noctalia-greeter = {
    enable = true;
    settings = {
      appearance = {
        hide_logo = true;
      };
    };
  };
}

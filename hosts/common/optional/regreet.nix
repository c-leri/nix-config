{
  services.greetd.enable = true;

  programs.regreet = {
    enable = true;
    settings = {
      widget.clock = {
        format = "%d/%m/%Y %H:%M";
      };
    };
  };
}

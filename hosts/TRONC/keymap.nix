{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,fr";
    variant = "intl";
  };

  environment.sessionVariables = {
    # Used by cage (regreet's compositor)
    XKB_DEFAULT_LAYOUT = "fr";
  };

  # Configure console keymap
  console.keyMap = "fr";
}

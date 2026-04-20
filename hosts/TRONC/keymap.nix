{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "fr,us";
    variant = "oss,intl";
  };

  environment.sessionVariables = {
    # Used by cage (regreet's compositor)
    XKB_DEFAULT_LAYOUT = "fr";
    XKB_DEFAULT_VARIANT = "oss";
  };

  # Tell the console to use x11 keymap
  console.useXkbConfig = true;
}

{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,fr";
    variant = "intl,oss";
  };

  environment.sessionVariables = {
    # Used by cage (regreet's compositor)
    XKB_DEFAULT_LAYOUT = "us";
    XKB_DEFAULT_VARIANT = "intl";
  };

  # Tell the console to use x11 keymap
  console.useXkbConfig = true;
}

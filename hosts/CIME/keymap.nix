{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Tell the console to use x11 keymap
  console.useXkbConfig = true;
}

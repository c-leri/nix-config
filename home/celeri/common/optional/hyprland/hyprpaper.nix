{
  services.hyprpaper = let
    background = ../../../../../background.jpg;
  in {
    enable = true;
    settings = {
      ipc = "off";
      splash = false;

      preload = ["${background}"];
      wallpaper = [
        "eDP-1, ${background}"
      ];
    };
  };
}

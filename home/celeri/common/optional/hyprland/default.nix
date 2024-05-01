{pkgs, ...}: {
  imports = [
    ./waybar
    ./rofi.nix
    ./wlogout.nix
    ./wpaperd.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = "eDP-1,1920x1080,0X0,1.25";

      env = ["NIXOS_OZONE_WL,1"];

      exec-once = [
        "${pkgs.dunst}/bin/dunst"
        "waybar"
        "wpaperd"
      ];

      input = {
        kb_layout = "fr";

        touchpad.natural_scroll = true;
      };

      gestures.workspace_swipe = true;

      # Programs
      "$terminal" = "wezterm";
      "$browser" = "floorp";
      "$fileManager" = "${pkgs.gnome.nautilus}/bin/nautilus";
      "$menu" = "rofi -show drun";
      "$window_picker" = "rofi -show window";

      bind =
        [
          "SUPER, A, exec, $terminal"
          "SUPER, Z, exec, $browser"
          "SUPER, E, exec, $fileManager"
          "SUPER, R, exec, $menu"
          "SUPER, Tab, exec, $window_picker"
          "SUPER, P, exec, wlogout"
          "SUPER, F, fullscreen,"
          "SUPER, W, killactive,"
        ]
        ++ (
          let
            top_row = [
              "ampersand"
              "eacute"
              "quotedbl"
              "apostrophe"
              "parenleft"
              "minus"
              "egrave"
              "underscore"
              "ccedilla"
              "agrave"
            ];
          in
            builtins.concatLists (
              builtins.genList (
                i: let
                  key = builtins.elemAt top_row i;
                in ["SUPER, ${key}, workspace, ${toString (i + 1)}"]
              )
              10
            )
        );

      general = {
        gaps_out = 10;
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.8;
      };

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        disable_hyprland_logo = true;
      };
    };
  };
}

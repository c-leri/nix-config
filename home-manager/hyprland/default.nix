{ pkgs, ... }:
{
  imports = [
    ./waybar
    ./rofi.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        "${pkgs.dunst}/bin/dunst"
        "waybar"
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

      bind = [
        "SUPER, A, exec, $terminal"
        "SUPER, Z, exec, $browser"
        "SUPER, E, exec, $fileManager"
        "SUPER, R, exec, $menu"
        "SUPER, F, fullscreen,"
        "SUPER, W, killactive,"
        "SUPER, P, exit,"
      ] ++ (
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
        builtins.concatLists (builtins.genList
          (
            i:
            let
              key = builtins.elemAt top_row i;
            in
            [
              "SUPER, ${key}, workspace, ${toString (i + 1)}"
            ]
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
    };
  };
}

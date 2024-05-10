{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./eww
    ./mako.nix
    ./rofi.nix
    ./hyprpaper.nix
    ./alacritty.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      input = {
        kb_layout = "fr";
        touchpad.natural_scroll = true;
      };

      monitor = [
        "eDP-1, 1920x1080, 0x0, 1.25"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "GDK_SCALE, 1.25"
        "QT_SCALE_FACTOR, 1.25"
        "XDG_SCREENSHOTS_DIR, ${config.home.homeDirectory}/Images/screenshots"
      ];

      xwayland.force_zero_scaling = true;

      general = {
        # Style
        border_size = 2;
        gaps_out = 10;
        gaps_workspaces = 10;
        "col.inactive_border" = "$crust";
        "col.active_border" = "$accent";
      };

      exec-once = [
        "eww open faketray; mullvad-vpn & megasync & keepassxc"
      ];

      decoration = {
        rounding = 10;
        inactive_opacity = 0.9;
      };

      "$mod" = "SUPER";
      "$terminal" = "alacritty";

      bind = [
        # General
        "$mod, Escape, exec, eww close powermenu || eww open powermenu"
        "$mod, Q, killactive,"
        "$mod, A, exec, rofi -show-icons -show drun"
        "ALT, Tab, exec, rofi -show-icons -show window"
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copysave area"

        # Apps
        "$mod, Return, exec, $terminal"
        "$mod, F, exec, floorp"

        # Window control
        "$mod, Up, movefocus, u"
        "$mod, Right, movefocus, r"
        "$mod, Down, movefocus, d"
        "$mod, Left, movefocus, l"
        "$mod SHIFT, Up, movewindow, u"
        "$mod SHIFT, Right, movewindow, r"
        "$mod SHIFT, Down, movewindow, d"
        "$mod SHIFT, Left, movewindow, l"
        "$mod, Page_Up, fullscreen, 2"
        "$mod, Page_Down, togglefloating"

        # Workspace control
        "$mod ALT, Right, workspace, r+1"
        "$mod ALT, Left, workspace, r-1"
        "$mod SHIFT ALT, Right, movetoworkspace, r+1"
        "$mod SHIFT ALT, Left, movetoworkspace, r-1"
      ];

      bindm = [
        "$mod CTRL, mouse:272, movewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bindl = [
        # Brightness
        ", XF86MonBrightnessDown, exec, light -U 10"
        ", XF86MonBrightnessUp, exec, light -A 10"

        # Volume
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];

      bindle = [
        # Volume
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
      ];

      gestures.workspace_swipe = true;

      misc.disable_hyprland_logo = true;
    };
  };
}

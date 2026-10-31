{
  programs.noctalia.settings = {
    shell.umbriel_overview_type_to_launch_enabled = true;
  };

  programs.umbriel.settings = {
    general.autostart = [ "noctalia" ];
    include.optional.files = [
      # Include umbriel displays config
      "outputs.toml"
    ];
    window_rule = [
      # Float noctalia settings
      {
        match.app_id = "^dev.noctalia.Noctalia$";
        default_floating = true;
        default_floating_size_px = {
          width = 1020;
          height = 900;
        };
      }
    ];
    layer_rule = [
      # Blur noctalia layers
      {
        match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";
        blur = true;
        blur_ignore_alpha = 0.5;
        blur_optimized = false;
      }
    ];
    keybinds = {
      "Mod+X" = {
        action = "spawn noctalia msg panel-toggle session";
        repeat = false;
      };
      "Mod+Space" = {
        action = "spawn noctalia msg panel-toggle launcher";
        repeat = false;
      };
      "Mod+L" = {
        action = "spawn noctalia msg session lock";
        repeat = false;
      };
      # Screenshot
      "Print" = {
        action = "spawn noctalia msg screenshot-region";
        repeat = false;
      };
      "Ctrl+Print" = {
        action = "spawn noctalia msg screenshot-fullscreen pick";
        repeat = false;
      };
      # Volume
      "XF86AudioRaiseVolume" = {
        action = "spawn noctalia msg volume-up";
        allow_when_locked = true;
      };
      "XF86AudioLowerVolume" = {
        action = "spawn noctalia msg volume-down";
        allow_when_locked = true;
      };
      "XF86AudioMute" = {
        action = "spawn noctalia msg volume-mute";
        allow_when_locked = true;
        repeat = false;
      };
      # Media
      "XF86AudioPlay" = {
        action = "spawn noctalia msg media toggle";
        allow_when_locked = true;
        repeat = false;
      };
      "XF86AudioNext" = {
        action = "spawn noctalia msg media next";
        allow_when_locked = true;
      };
      "XF86AudioPrev" = {
        action = "spawn noctalia msg media previous";
        allow_when_locked = true;
      };
      # Brightness
      "XF86MonBrightnessUp" = {
        action = "spawn noctalia msg brightness-up";
        allow_when_locked = true;
      };
      "XF86MonBrightnessDown" = {
        action = "spawn noctalia msg brightness-down";
        allow_when_locked = true;
      };
    };
  };
}

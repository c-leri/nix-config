{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  home.packages = with pkgs; [
    pwvucontrol # Volume control gui
    wl-mirror # Mirror screen
  ];

  home.file."${config.programs.noctalia.settings.wallpaper.directory}" = {
    source = ../../../../../public/wallpapers;
    recursive = true;
  };

  programs.noctalia = {
    enable = true;
    settings = {
      shell = {
        polkit_agent = true;
        show_close_buttons = false;
        screenshot.directory = "${config.xdg.userDirs.pictures}/Screenshots";
      };
      backdrop.enabled = true;
      wallpaper.directory = "${config.xdg.userDirs.pictures}/Wallpapers";
      # Get location from ip
      location.auto_locate = true;
      # Control external monitor brightness
      brightness.enable_ddcutil = true;
      # Control center
      control_center = {
        width = 800;
        sidebar_section = "none";
        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "clipboard"; }
          { type = "power_profile"; }
          { type = "caffeine"; }
          { type = "nightlight"; }
        ];
      };
      shell.panel.open_near_click_control_center = true;
      # Calendar
      calendar = {
        enabled = true;
        account.google.type = "google";
      };
      # Lockscreen
      lockscreen.blurred_desktop = true;
      # Session menu
      shell.panel = {
        session_placement = "floating";
        session_position = "center";
      };
      shell.session = {
        grid = true;
        grid_columns = 2;
        actions = [
          {

            action = "lock";
            shortcut = "1";
          }
          {
            action = "logout";
            shortcut = "2";
          }
          {
            action = "lock_and_suspend";
            shortcut = "3";
          }
          {
            action = "command";
            command = "noctalia msg session lock & systemctl hibernate";
            glyph = "hibernate";
            label = "Vérouiller et hiberner";
            shortcut = "4";
          }
          {
            action = "reboot";
            shortcut = "5";
          }
          {
            action = "shutdown";
            shortcut = "6";
            variant = "destructive";
          }
        ];
      };
      # Bar
      bar.default = {
        capsule = true;
        radius = 0;
        margin_ends = 0;
        start = [
          "workspaces"
          "group:g1"
          "active_window"
          "audio_visualizer"
        ];
        center = [ "clock" ];
        end = [
          "status"
          "keyboard_layout"
          "tray"
          "prponkshe/umbriel-displays:bar"
          "elijaharch/wl-screen-mirror:mirror"
          "notifications"
          "volume"
          "brightness"
          "battery"
          "nix-monitor"
          "control-center"
        ];
        capsule_group = [
          {
            id = "g1";
            members = [
              "cpu"
              "temp"
              "ram"
            ];
          }
        ];
        dead_zone.actions = {
          middle = "settings-toggle";
          scroll_down = "workspace-switch next";
          scroll_up = "workspace-switch prev";
        };
      };
      # Widgets
      widget = {
        clock = {
          format = "{:%R - %x}";
        };
        cpu = {
          show_value = false;

          actions = {
            middle = "exec missioncenter";
          };
        };
        temp = {
          show_value = false;
          actions = {
            middle = "exec missioncenter";
          };
        };
        ram = {
          show_value = false;
          actions = {
            middle = "exec missioncenter";
          };
        };
        active_window = {
          min_length = 0;
          title_scroll = "on_hover";
        };
        audio_visualizer.actions = {
          left = "panel-toggle control-center media";
        };
        volume.actions = {
          middle = "exec pwvucontrol";
        };
        status = {
          type = "aristides/udiskie";
          hide_when_empty = true;
        };
        nix-monitor = {
          type = "avivbintangaringga/nix-monitor:nix-monitor";
          show_text = false;
          up_to_date_color = "tertiary";
          checking_color = "primary";
          update_available_color = "secondary";
        };
      };
      # Dock
      dock = {
        enabled = true;
        margin_edge = 12;
        main_axis_padding = 8;
        active_monitor_only = true;
        smart_auto_hide = true;
        reserve_space = false;
        show_dots = true;
      };
      # Night light
      nightlight = {
        enabled = true;
        temperature_night = 5500;
      };
      # Plugins
      plugins = {
        source = [
          {
            enabled = true;
            name = "official";
            kind = "git";
            location = "https://github.com/noctalia-dev/noctalia-plugins";
          }
          {
            enabled = true;
            name = "community";
            kind = "git";
            location = "https://github.com/noctalia-dev/community-plugins";
          }
        ];
        enabled = [
          "prponkshe/umbriel-displays"
          "elijaharch/wl-screen-mirror"
          "whyoolw/sharednd"
          "aristides/udiskie"
          "avivbintangaringga/nix-monitor"
        ];
      };
      # Plugins settings
      plugin_settings = {
        "aristides/udiskie" = {
          file_manager_cmd = "nautilus";
        };
        "avivbintangaringga/nix-monitor" = {
          branch = "nixos-unstable";
          clean_command = "nh clean all";
          update_command = "nh os boot -ua";
        };
      };
    };
  };
}

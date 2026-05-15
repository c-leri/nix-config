{ config, pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    config = {
      profile = "high-quality";
      hwdec = "auto";
      slang = "fr,en";
      watch-later-options-remove = [
        "sub-pos"
        "osd-margin-y"
      ];
    };
    scripts = with pkgs.mpvScripts; [
      pkgs.mpvScripts.builtins.autoload
      modernz
      mpris
      thumbfast
      webtorrent-mpv-hook
    ];
    scriptOpts = {
      modernz = {
        hide_empty_playlist_button = true;
        ontop_button = false;
        screenshot_button = false;
        download_path = config.xdg.userDirs.download;
        seek_handle_color = "#000000";
        seek_handle_border_color = config.lib.stylix.colors.withHashtag.base0D;
      };
    };
  };
}

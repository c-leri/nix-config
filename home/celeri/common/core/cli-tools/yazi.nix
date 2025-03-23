{pkgs, ...}: let
  yazi-plugins = pkgs.fetchFromGitHub {
    owner = "yazi-rs";
    repo = "plugins";
    rev = "4a6edc3349a2a9850075363965d05b9063817df4";
    hash = "sha256-RYa7wbFGZ9citYYdF9FYJwzUGBmIUvNBdORpBPb6ZnQ=";
  };
in {
  programs.yazi = {
    enable = true;
    plugins = {
      no-status = "${yazi-plugins}/no-status.yazi";
    };
  };
}

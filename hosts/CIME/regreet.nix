{ lib, pkgs, ... }:
let
  regreetScript = pkgs.writeShellScriptBin "mirrored-regreet.sh" ''
    # Stack both display so that regreet is mirrored on both of them
    ${lib.getExe pkgs.wlr-randr} --output DP-2 --mode 2560x1440 --pos 0,0;
    if ! ${lib.getExe pkgs.wlr-randr} --output HDMI-A-1 --mode 2560x1440 --pos 0,0; then
      # Turn off the TV if it cant stacked
      ${lib.getExe pkgs.wlr-randr} --output HDMI-A-1 --off;
    fi
    ${lib.getExe pkgs.regreet};
  '';
in
{
  services.greetd = {
    settings = {
      default_session = {
        command = "${lib.getExe' pkgs.dbus "dbus-run-session"} ${lib.getExe pkgs.cage} -s -d -- ${lib.getExe regreetScript}";
      };
    };
  };
}

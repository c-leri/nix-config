{
  config,
  pkgs,
  lib,
  ...
}:
let
  regreetScript = pkgs.writeShellScriptBin "mirrored-regreet.sh" ''
    # Stack both monitors so that regreet is mirrored on both of them
    ${lib.getExe pkgs.wlr-randr} --output DP-1 --mode 2560x1440 --pos 0,0;
    ${lib.getExe pkgs.wlr-randr} --output DP-2 --mode 2560x1440 --pos 0,0;
    # Turn off the TV
    ${lib.getExe pkgs.wlr-randr} --output HDMI-A-1 --off;
    ${lib.getExe config.programs.regreet.package};
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

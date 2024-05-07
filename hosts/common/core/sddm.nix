{pkgs, ...}: let
  theme = pkgs.catppuccin-sddm-corners.overrideAttrs (old: {
    dontBuild = false;

    nativeBuildInputs = [pkgs.sd];

    buildPhase = ''
      set_conf () {
        if [ $# != 2 ]; then
          echo "Expected 2 arguments, found $#"
          exit 1
        fi

        sd "$1=\".*\"" "$1=\"$2\"" catppuccin/theme.conf
      }

      set_conf Background "${../../../background.jpg}"
      set_conf GeneralFontSize 14

      set_conf UserPictureBorderColor "#c6a0f6"
      set_conf UserPictureColor "#24273a"

      set_conf TextFieldColor "#24273a"
      set_conf TextFieldTextColor "#cad3f5"
      set_conf TextFieldHighlightColor "#c6a0f6"

      set_conf LoginButtonTextColor "#181926"
      set_conf LoginButtonBgColor "#c6a0f6"

      set_conf PopupBgColor "#24273a"
      set_conf PopupHighlightColor "#c6a0f6"
      set_conf PopupHighlightedTextColor "#24273a"

      set_conf SessionButtonColor "#24273a"
      set_conf SessionIconColor "#c6a0f6"

      set_conf PowerButtonColor "#ed8796"
      set_conf PowerIconColor "#181926"

      set_conf DateColor "#cad3f5"
      set_conf DateFormat "dddd d MMMM"

      set_conf TimeColor "#c6a0f6"
      set_conf TimeFormat "HH:mm"
    '';
  });
in {
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "${theme}/share/sddm/themes/catppuccin-sddm-corners";
    extraPackages = with pkgs.libsForQt5.qt5; [
      qtgraphicaleffects
      qtsvg
      qtquickcontrols2
    ];
  };
}

{ pkgs, lib, ... }:

let
  extra-path = with pkgs; [
    dotnetCorePackages.sdk_6_0
    dotnetPackages.Nuget
    mono
    msbuild
  ];

  extra-lib = [ ];

  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = ''
      # Wrap rider with extra tools and libraries
      touch $out/coucou.txt
      mv $out/bin/rider $out/bin/.rider-toolless
      makeWrapper $out/bin/.rider-toolless $out/bin/rider \
        --argv0 rider \
        --prefix PATH : "${lib.makeBinPath extra-path}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"

      # Making Unity Rider plugin work!
      shopt -s extglob
      ln -s $out/rider/!(bin) $out/
      shopt -u extglob
    '' + attrs.postInstall or "";
  });
in
{
  # Allows Unity Login to actually open a browser
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
    ];
    configPackages = [
      pkgs.gnome.gnome-session
    ];
  };

  home-manager.users.celeri.home = {
    packages = [
      pkgs.unityhub
      rider
    ];

    # Dummy .desktop file for the Unity Rider plugin
    file = {
      ".local/share/applications/jetbrains-rider.desktop".source =
        let
          desktopFile = pkgs.makeDesktopItem {
            name = "jetbrains-rider";
            desktopName = "Rider";
            exec = "\"${rider}/bin/rider\"";
            icon = "rider";
            type = "Application";
            extraConfig.NoDisplay = "true";
          };
        in
        "${desktopFile}/share/applications/jetbrains-rider.desktop";
    };
  };
}

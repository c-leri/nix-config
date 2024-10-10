{
  pkgs,
  lib,
  ...
}: let
  extra-path = with pkgs.unstable; [
    dotnetCorePackages.sdk_8_0_3xx
    dotnetPackages.Nuget
    mono
    msbuild
    # Add any extra binaries you want accessible to Rider here
  ];

  extra-lib = with pkgs; [
    # Add any extra libraries you want accessible to Rider here
  ];

  rider = pkgs.unstable.jetbrains.rider.overrideAttrs (attrs: {
    postInstall =
      ''
        # Wrap rider with extra tools and libraries
        mv $out/bin/rider $out/bin/.rider-toolless
        makeWrapper $out/bin/.rider-toolless $out/bin/rider \
          --argv0 rider \
          --prefix PATH : "${lib.makeBinPath extra-path}" \
          --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"
      ''
      + attrs.postInstall or "";
  });
in {
  home.packages = [
    rider
  ];
}

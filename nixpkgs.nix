{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      (final: prev: {
        nautilus = prev.nautilus.overrideAttrs (nprev: {
          buildInputs =
            nprev.buildInputs
            ++ (with final.gst_all_1; [
              # Get aditional info in videos properties
              gst-plugins-good
            ]);
          preFixup = ''
            gappsWrapperArgs+=(
              # Thumbnailers
              --prefix XDG_DATA_DIRS : "${final.glycin-thumbnailer}/share"
              --prefix XDG_DATA_DIRS : "${final.ffmpegthumbnailer}/share"
            )
          '';
        });
      })
    ];
  };
}

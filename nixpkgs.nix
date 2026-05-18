{
  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      # Fix for https://github.com/NixOS/nixpkgs/issues/514113
      (_: prev: {
        openldap = prev.openldap.overrideAttrs {
          doCheck = !prev.stdenv.hostPlatform.isi686;
        };
      })
    ];
  };
}

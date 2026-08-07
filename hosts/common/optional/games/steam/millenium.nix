{ inputs, pkgs, ... }:
let
  millennium = inputs.millennium.packages.${pkgs.stdenv.hostPlatform.system}.millennium;
  millenniumEnv = {
    MILLENNIUM_RUNTIME_PATH = "${millennium}/lib/libmillennium_x86.so";
  };
  millenniumProfile = ''
    ln -sf ${millennium}/lib/libmillennium_bootstrap_x86.so "$HOME/.local/share/Steam/ubuntu12_32/libXtst.so.6"
    ln -sf ${millennium}/lib/libmillennium_bootstrap_hhx64.so "$HOME/.local/share/Steam/ubuntu12_64/libXtst.so.6"
  '';
in
{
  # Add millennium to steam manually instead of rellying on millennium-steam to preserve compatibility with jovian
  programs.steam = {
    package = pkgs.steam.override {
      extraEnv = millenniumEnv;
      extraProfile = millenniumProfile;
    };
    extraPackages = with pkgs; [
      millennium
      pkgsi686Linux.openssl
      openssl
    ];
  };
}

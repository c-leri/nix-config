{pkgs, ...}: {
  imports = [
    ./rust.nix
  ];

  home.packages = with pkgs; [
    bun
    deno
    nodejs_20
    corepack_20
    python3
  ];

  home.sessionVariables = {
    COREPACK_ENABLE_AUTO_PIN = 0;
  };
}

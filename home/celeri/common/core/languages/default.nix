{pkgs, ...}: {
  imports = [
    ./rust.nix
  ];

  home.packages = with pkgs; [
    unstable.bun
    unstable.deno
    nodejs_20
    corepack_20
    jdk21
    python3
  ];
}

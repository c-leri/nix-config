{pkgs, ...}: {
  imports = [
    ./node.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    bun
    jdk21
    python3
  ];
}

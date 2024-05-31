{pkgs, ...}: {
  imports = [
    ./node.nix
    ./rust.nix
  ];

  home.packages = with pkgs; [
    unstable.bun
    jdk21
    python3
  ];
}

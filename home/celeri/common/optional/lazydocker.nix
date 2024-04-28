{pkgs, ...}: {
  home.packages = [pkgs.lazydocker];

  programs.fish.shellAliases.ldocker = "lazydocker";
}

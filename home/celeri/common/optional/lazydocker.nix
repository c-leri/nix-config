{pkgs, ...}: {
  home.packages = [pkgs.lazydocker];

  programs.zsh.shellAliases.ldocker = "lazydocker";
}

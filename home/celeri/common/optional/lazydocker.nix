{pkgs, ...}: {
  home.packages = with pkgs; [
    lazydocker
  ];

  programs.zsh.shellAliases.ldocker = "lazydocker";
}

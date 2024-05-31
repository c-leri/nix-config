{pkgs, ...}: {
  home.packages = [
    pkgs.texliveFull
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      editorconfig.editorconfig
      usernamehw.errorlens
      dbaeumer.vscode-eslint
      tamasfe.even-better-toml
      mhutchie.git-graph
      esbenp.prettier-vscode
      jock.svg
    ];
  };
}

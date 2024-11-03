{pkgs, ...}: {
  home.packages = [
    pkgs.texliveFull
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      catppuccin.catppuccin-vsc
      catppuccin.catppuccin-vsc-icons
      editorconfig.editorconfig
      usernamehw.errorlens
      tamasfe.even-better-toml
      redhat.vscode-yaml
      redhat.vscode-xml
      jock.svg
    ];
  };
}

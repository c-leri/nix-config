{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      editorconfig.editorconfig
      usernamehw.errorlens
      tamasfe.even-better-toml
      redhat.vscode-yaml
      redhat.vscode-xml
      jock.svg
    ];
  };
}

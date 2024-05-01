{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    nodejs_20
    nodePackages.pnpm
  ];

  home.sessionVariables = {
    # Set the PNPM_HOME env variable
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
  };

  home.sessionPath = [
    # Add PNPM_HOME to the path
    "$PNPM_HOME"
  ];
}

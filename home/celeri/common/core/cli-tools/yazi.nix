{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    # TODO: remove once 7zz package builds again
    package = pkgs.stable.yazi;
    catppuccin.enable = true;
  };
}

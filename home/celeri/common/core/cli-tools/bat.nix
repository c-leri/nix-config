{pkgs, ...}: {
  programs.bat = {
    enable = true;
    # TODO: removes once bat works normally again
    package = pkgs.stable.bat;
    catppuccin.enable = true;
    config = {
      pager = "less -F";
    };
  };
}

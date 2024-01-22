{
  programs.gitui = {
    enable = true;
    theme = ''
      (
        selection_bg: Some(Reset),
        selection_fg: Some(Blue),
        cmdbar_bg: Some(Reset),
        cmdbar_extra_lines_bg: Some(Reset),
        push_gauge_bg: Some(Reset),
        push_gauge_fg: Some(Blue),
      )
    '';
  };

  programs.git = {
    enable = true;
    userName = "celeri";
    userEmail = "celestin.bouchet@gmail.com";

    delta = {
      enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
      gpg.format = "ssh";
      user.signingkey = "/home/celeri/.ssh/id_ed25519.pub";
      commit.gpgSign = true;
    };
  };
}

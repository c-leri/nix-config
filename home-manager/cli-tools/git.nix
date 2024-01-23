{
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

  programs.lazygit = {
    enable = true;
    settings = {
      gui.theme = {
        activeBorderColor = [ "#a6da95" "bold" ];
        inactiveBorderColor = [ "#a5adcb" ];
        optionsTextColor = [ "#8aadf4" ];
        selectedLineBgColor = [ "#363a4f" ];
        selectedRangeBgColor = [ "#363a4f" ];
        cherryPickedCommitBgColor = [ "#494d64" ];
        cherryPickedCommitFgColor = [ "#a6da95" ];
        unstagedChangesColor = [ "#ed8796" ];
        defaultFgColor = [ "#cad3f5" ];
        searchingActiveBorderColor = [ "#eed49f" ];
      };
    };
  };
}

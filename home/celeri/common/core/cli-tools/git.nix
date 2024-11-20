{config, ...}: {
  programs.git = {
    enable = true;
    userName = config.home.username;
    userEmail = "celestin.bouchet@gmail.com";

    delta = {
      enable = true;
      catppuccin.enable = true;
      options = {
        navigate = true;
        side-by-side = true;
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
      # Use helix as git's editor
      core.editor = "hx";
      user.signingkey = "${config.home.homeDirectory}/${config.home.file.ssh-public-key.target}";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "${config.home.homeDirectory}/${config.home.file.ssh-allowed-signers.target}";
      };
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
  };

  programs.lazygit = {
    enable = true;
    catppuccin.enable = true;
    settings = {
      gui.theme = {
        activeBorderColor = [
          "#a6da95"
          "bold"
        ];
        inactiveBorderColor = ["#a5adcb"];
        optionsTextColor = ["#8aadf4"];
        selectedLineBgColor = ["#363a4f"];
        selectedRangeBgColor = ["#363a4f"];
        cherryPickedCommitBgColor = ["#494d64"];
        cherryPickedCommitFgColor = ["#a6da95"];
        unstagedChangesColor = ["#ed8796"];
        defaultFgColor = ["#cad3f5"];
        searchingActiveBorderColor = ["#eed49f"];
      };
    };
  };
}

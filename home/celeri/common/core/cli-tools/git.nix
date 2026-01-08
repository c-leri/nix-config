{ config, ... }:
{
  programs.git = {
    enable = true;

    settings = {
      init.defaultBranch = "main";

      # Use helix as git's editor
      core.editor = "hx";

      user = {
        name = config.home.username;
        email = "celestin.bouchet@gmail.com";
        signingkey = "${config.home.homeDirectory}/${config.home.file.ssh-public-key.target}";
      };

      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "${config.home.homeDirectory}/${config.home.file.ssh-allowed-signers.target}";
      };
      commit.gpgSign = true;
      tag.gpgSign = true;
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
      side-by-side = true;
    };
  };

  programs.lazygit.enable = true;
}

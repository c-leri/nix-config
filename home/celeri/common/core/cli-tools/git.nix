{ config, ... }:
{
  programs.git = {
    enable = true;

    signing = {
      format = "ssh";
      key = "${config.home.homeDirectory}/${config.home.file.ssh-public-key.target}";
      signByDefault = true;
    };

    settings = {
      init.defaultBranch = "main";

      # Use helix as git's editor
      core.editor = "hx";

      user = {
        name = config.home.username;
        email = "celestin.bouchet@gmail.com";
      };

      gpg.ssh.allowedSignersFile = "${config.home.homeDirectory}/${config.home.file.ssh-allowed-signers.target}";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      navigate = true;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.pagers = [
        {
          pager = "delta --paging=never --line-numbers --hyperlinks --hyperlinks-file-link-format='lazygit-edit://{path}:{line}'";
        }
      ];
    };
  };

  home.shellAliases.lgit = "lazygit";
}

{ config, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = config.home.username;
        email = "celestin.bouchet@gmail.com";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = "~/${config.home.file.ssh-public-key.target}";
        backends.ssh.allowed-signers = "~/${config.home.file.ssh-allowed-signers.target}";
      };
      ui = {
        default-command = [ "log" ];
        log-word-wrap = true;
        show-cryptographic-signatures = true;
      };
      "--scope" = [
        {
          "--when.environments" = [ "JJUI" ];
          ui = {
            diff-formatter = [
              "delta"
              "--width"
              "$width"
              "$left"
              "$right"
            ];
          };
        }
      ];
    };
  };

  programs.delta.enableJujutsuIntegration = true;

  programs.jjui = {
    enable = true;
    settings = {
      preview.show_at_start = true;
      actions = [
        {
          name = "edit-file";
          desc = "open file in editor";
          scope = "revisions.details";
          key = "alt+e";
          lua = ''
            exec_shell("$EDITOR "..context.file())
          '';
        }
      ];
    };
  };
}

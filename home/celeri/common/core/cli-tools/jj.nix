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
    };
  };

  programs.delta.enableJujutsuIntegration = true;
}

{
  sops = {
    age = {
      sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets.searxEnvironmentFile = {
      sopsFile = ../../../secrets/searx_environment_file;
      format = "binary";
    };
  };
}

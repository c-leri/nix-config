# NixOS and Home Manager Configuration Flake

## Guides

### Adding Host (sops)

- Get the age key of a user and put it in `~/.config/sops/age/keys.txt`

- Generate the host's ssh keys
  ```
    sudo ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
  ```

- Generate the host's age public key
  ```
    cat /etc/ssh/ssh_host_ed25519_key.pub | nix run nixpkgs#ssh-to-age
  ```

- Copy resulting key to `.sops.yaml` under `keys.hosts` with the name of the new host

- Upate the keys of the secrets
  ```
    nix run nixpkgs#sops updatekeys secrets/searx_envrionment_file
    nix run nixpkgs#sops updatekeys secrets/celeri.yaml
  ```

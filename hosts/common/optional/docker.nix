{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
  ];

  environment.shellAliases.ldocker = "lazydocker";

  specialisation = {
    kind.configuration = {
      # Workaround for firewall causing issues with kind's dns https://discourse.nixos.org/t/dns-fails-in-a-multinode-k8s-kind-cluster/60988
      networking.firewall.checkReversePath = false;

      environment.systemPackages = with pkgs; [
        kind
        kubectl
        kubernetes-helm
      ];
    };
  };
}

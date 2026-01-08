{ pkgs, ... }:
{
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    lazydocker
  ];

  environment.shellAliases.ldocker = "lazydocker";
}

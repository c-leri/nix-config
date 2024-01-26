{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.celeri.extraGroups = [ "libvirtd" ];

  home-manager.users.celeri.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
}

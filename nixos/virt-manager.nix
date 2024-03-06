{
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  home-manager.users.celeri.dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };
  users.users.celeri.extraGroups = [ "libvirtd" ];
}

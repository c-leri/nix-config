{ config, ... }:
{
  programs.wpaperd = {
    enable = true;
    settings = {
      eDP-1 = {
        path = "${config.home.homeDirectory}/Images/parasite.jpg";
      };
    };
  };
}

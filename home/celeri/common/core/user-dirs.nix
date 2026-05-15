{ config, ... }:
{
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    desktop = "${config.home.homeDirectory}/Bureau";
    documents = "${config.home.homeDirectory}/Documents";
    download = "${config.home.homeDirectory}/Téléchargements";
    music = "${config.home.homeDirectory}/Musique";
    pictures = "${config.home.homeDirectory}/Images";
    projects = "${config.home.homeDirectory}/Projets";
    videos = "${config.home.homeDirectory}/Vidéos";
    publicShare = null;
    templates = null;
  };
}

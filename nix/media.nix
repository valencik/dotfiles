# Media setup

{ config, pkgs, ... }:

{

  # Plex
  # https://plex.tv/
  # http://localhost:32400 
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # TV
  # https://sonarr.tv/
  services.sonarr = {
    enable = true;
    openFirewall = true;
  };

  # Movies
  # https://radarr.video/
  services.radarr = {
    enable = true;
    openFirewall = true;
  };

  # Torrents
  # https://deluge-torrent.org/
  services.deluge = {
    package = pkgs.deluge-2_x;
    enable = true;
    web.enable = true;
  };

  # Usenet NZB downloader
  # https://sabnzbd.org/
  services.sabnzbd = {
    enable = true;
  };
}
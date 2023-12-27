# Media setup

{ config, pkgs, ... }:

{
  users.groups.media.members = [
    "plex"
    "sonarr"
    "radarr"
    "deluge"
    "sabnzbd"
  ];

  # Plex
  # https://plex.tv/
  # http://localhost:32400 
  services.plex = {
    enable = true;
    openFirewall = true;
  };

  # TV
  # https://sonarr.tv/
  # http://localhost:8989
  services.sonarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  # Movies
  # https://radarr.video/
  # http://localhost:7878/
  services.radarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };

  # Torrents
  # https://deluge-torrent.org/
  # http://localhost:8112/
  services.deluge = {
    package = pkgs.deluge-2_x;
    enable = true;
    web.enable = true;
    group = "media";
    openFirewall = true;
  };
  # Open Deluge web port in the firewall.
  networking.firewall.allowedTCPPorts = [
    8112
  ];

  # Usenet NZB downloader
  # https://sabnzbd.org/
  # http://localhost:8969/
  services.sabnzbd = {
    enable = true;
    group = "media";
  };
}

# Media setup

{ config, pkgs, ... }:

{
  users.groups.media.members = [
    "andrew"
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
    group = "media";
    openFirewall = true;
  };
  # https://discourse.nixos.org/t/solved-sonarr-is-broken-in-24-11-unstable-aka-how-the-hell-do-i-use-nixpkgs-config-permittedinsecurepackages/56828
  nixpkgs.config.permittedInsecurePackages = [
    "aspnetcore-runtime-6.0.36"
    "aspnetcore-runtime-wrapped-6.0.36"
    "dotnet-sdk-6.0.428"
    "dotnet-sdk-wrapped-6.0.428"
  ];

  # Movies
  # https://radarr.video/
  # http://localhost:7878/
  services.radarr = {
    enable = true;
    group = "media";
    openFirewall = true;
  };

  # Books
  # https://readarr.com
  # http://localhost:8787/
  services.readarr = {
    enable = true;
    group = "media";
    openFirewall = true;
  };

  # Torrents
  # https://deluge-torrent.org/
  # http://localhost:8112/
  services.deluge = {
    package = pkgs.deluge-2_x;
    enable = true;
    openFilesLimit = 12000;
    declarative = true;
    authFile = "/var/lib/deluge/.config/deluge/deluge-auth";
    config = {
      download_location = "/bigdata/torrents";
      max_upload_speed = 80000;
      listen_ports = [ 56765 57675 ];
      enabled_plugins = [ "Label" ];
    };
    web.enable = true;
    web.port = 8112;
    web.openFirewall = true;
    group = "media";
    openFirewall = true;
  };

  # Usenet NZB downloader
  # https://sabnzbd.org/
  # http://localhost:8969/
  services.sabnzbd = {
    enable = true;
    group = "media";
    openFirewall = true;
  };
}

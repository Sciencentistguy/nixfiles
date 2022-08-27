{pkgs, ...}: {
  services.plex = {
    enable = true;
    dataDir = "/nas/plex/library_data";
    openFirewall = true;
  };

  systemd.services.plex.serviceConfig.PIDFile = "/nas/plex/library_data/Plex Media Server/plexmediaserver.pid";
}

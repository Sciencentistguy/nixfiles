{pkgs, ...}: {
  services.plex = {
    enable = false;
    dataDir = "/storage-pool/services/plex/library_data";
    openFirewall = true;
  };

  systemd.services.plex.serviceConfig.PIDFile = "/storage-pool/services/plex/library_data/Plex Media Server/plexmediaserver.pid";
}

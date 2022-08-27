{pkgs, ...}: {
  services.plex = {
    enable = true;
    dataDir = "/nas/plex/library_data";
    openFirewall = true;
  };
}

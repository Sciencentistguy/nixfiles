{pkgs, ...}: {
  services.syncthing = {
    enable = true;
    user = "jamie";
    dataDir = "/home/jamie/Sync"; # Default folder for new synced folders
    configDir = "/home/jamie/Sync/.config/syncthing"; # Folder for Syncthing's settings and keys
    guiAddress = "0.0.0.0:8384";
  };

  networking.firewall.allowedTCPPorts = [8384 22000];
  networking.firewall.allowedUDPPorts = [22000 21027];
}

{pkgs, ...}: {
  services.borgbackup.jobs = {
    "influxdb" = {
      paths = "/storage-pool/services/influxdb";
      encryption = {
        mode = "none";
      };
      repo = "/storage-pool/backups/borg/influxdb";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}

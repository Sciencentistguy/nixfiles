{pkgs, ...}: {
  services.borgbackup.jobs = {
    "influxdb" = {
      paths = "/nas/docker-store/influxdb";
      encryption = {
        mode = "none";
      };
      repo = "/nas/backup/influxdb";
      compression = "auto,zstd";
      startAt = "daily";
    };
  };
}

{pkgs, ...}: {
  systemd.timers."photo-backup" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      Unit = "photo-backup";
    };
  };

  systemd.services."photo-backup" = {
    script = let
      regexp = "\\.+.*"; # match any file starting with a dot
    in ''
      ${pkgs.rclone}/bin/rclone copy \
          --transfers=16 \
          --checkers=16 \
          /storage-pool/photos/Files \
          photos: \
          --exclude '{{${regexp}}}' \
          --exclude 'Thumbs.db' \
          --stats 30s \
          --stats-one-line \
          --stats-log-level NOTICE
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "backup";
      AmbientCapabilities = "CAP_DAC_OVERRIDE";
    };
  };

  users.users."backup" = {
    isSystemUser = true;
    group = "users";
    shell = "${pkgs.shadow}/bin/nologin";
    home = "/home/backup";
    createHome = true;
  };
}

{pkgs, ...}: {
  # Real disks
  fileSystems = {
    "/hdd" = {
      device = "/dev/disk/by-uuid/5e7178bf-d45a-4b45-8a07-2099cafd4ea6";
      fsType = "btrfs";
    };
    "/windows/c" = {
      device = "/dev/disk/by-uuid/4CCE434ACE432B90";
      fsType = "ntfs";
      options = ["uid=jamie" "gid=users"];
      noCheck = true;
    };
    "/windows/d" = {
      device = "/dev/disk/by-uuid/149247C59247AA56";
      fsType = "ntfs";
      options = ["uid=jamie" "gid=users"];
      noCheck = true;
    };
    "/atlas" = {
      fsType = "fuse";
      device = "${pkgs.sshfs-fuse}/bin/sshfs#jamie@100.88.57.38:/";
      options = ["noauto" "x-systemd.automount" "uid=jamie" "gid=users" "allow_other" "nofail" "x-systemd.device-timeout=15s"];
    };
    # nfs
    "/ingest" = {
      device = "fileserver.axolotl-shark.ts.net:/share/ingest";
      fsType = "nfs";
      options = ["noauto" "x-systemd.automount" "nofail" "x-systemd.device-timeout=15s"];
    };
    "/photos" = {
      device = "fileserver.axolotl-shark.ts.net:/share/photos";
      fsType = "nfs";
      options = ["noauto" "x-systemd.automount" "nofail" "x-systemd.device-timeout=15s"];
    };
    "/media" = {
      device = "fileserver.axolotl-shark.ts.net:/share/media";
      fsType = "nfs";
      options = ["noauto" "x-systemd.automount" "nofail" "x-systemd.device-timeout=15s"];
    };
  };

  # Virtual fielsystems
  fileSystems = {
    "/binds/music-library" = {
      device = "/media/Music";
      options = ["bind" "ro" "noauto"];
    };
  };

  boot.tmp.useTmpfs = true;
}

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
    };
    "/windows/d" = {
      device = "/dev/disk/by-uuid/149247C59247AA56";
      fsType = "ntfs";
      options = ["uid=jamie" "gid=users"];
    };
    "/atlas" = {
      fsType = "fuse";
      device = "${pkgs.sshfs-fuse}/bin/sshfs#jamie@100.88.57.38:/";
      options = ["noauto" "x-systemd.automount" "uid=jamie" "gid=users" "allow_other"];
    };
  };

  #Virtual fielsystems
  fileSystems = {
    "/binds/music-library" = {
      device = "/hdd/Music/beets";
      options = [
        "bind"
        "ro"
      ];
    };
  };

  boot.tmp.useTmpfs = true;
}

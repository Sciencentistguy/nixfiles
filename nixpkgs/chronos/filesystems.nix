{ pkgs, ... }: {

  fileSystems = {
    "/hdd" = {
      device = "/dev/disk/by-uuid/08691794-6fea-4a6c-9aac-bab29a4a9818";
      fsType = "btrfs";
    };
    "/windows/c" = {
      device = "/dev/disk/by-uuid/4CCE434ACE432B90";
      fsType = "ntfs";
      options = [ "uid=jamie" "gid=users" ];
    };
    "/windows/d" = {
      device = "/dev/disk/by-uuid/149247C59247AA56";
      fsType = "ntfs";
      options = [ "uid=jamie" "gid=users" ];
    };
  };
}

{pkgs, ...}: {
  fileSystems = {
    "/nas" = {
      device = "/dev/disk/by-uuid/50830e2e-c132-4171-ab77-224e7f505c06";
      fsType = "btrfs";
    };
  };

  #Virtual fielsystems
  fileSystems = {
    "/music" = {
      device = "/nas/plex/Music";
      options = [
        "bind"
        "ro"
      ];
    };
    "/tv" = {
      device = "/nas/plex/TV";
      options = [
        "bind"
        "ro"
      ];
    };
    "/movies" = {
      device = "/nas/plex/Films";
      options = [
        "bind"
        "ro"
      ];
    };
  };

  boot.tmpOnTmpfs = true;
}

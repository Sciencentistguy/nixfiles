{pkgs, ...}: {
  fileSystems = {
    "/nas" = {
      device = "/dev/disk/by-uuid/50830e2e-c132-4171-ab77-224e7f505c06";
      fsType = "btrfs";
    };
  };
}

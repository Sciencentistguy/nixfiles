{pkgs, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["storage-pool"];

  # limit ZFS arc size to 16 GiB
  boot.kernelParams = let
    bytes = 16 * (1024 * 1024 * 1024);
  in ["zfs.zfs_arc_max=${toString bytes}"];

  fileSystems = {
    "/nas" = {
      device = "/dev/disk/by-uuid/50830e2e-c132-4171-ab77-224e7f505c06";
      fsType = "btrfs";
    };
  };

  boot.tmpOnTmpfs = true;
}

{pkgs, ...}: {
  boot.supportedFilesystems = ["zfs"];
  boot.zfs.extraPools = ["scratch" "storage-pool"];

  # limit ZFS arc size to 16 GiB
  boot.kernelParams = let
    bytes = 16 * (1024 * 1024 * 1024);
  in ["zfs.zfs_arc_max=${toString bytes}"];

  boot.tmpOnTmpfs = true;
}

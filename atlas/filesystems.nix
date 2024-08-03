{pkgs, ...}: {
  boot.supportedFilesystems = ["zfs" "ntfs"];
  boot.zfs.extraPools = ["scratch" "storage-pool"];

  boot.tmp.useTmpfs = true;
}

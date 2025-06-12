{writeShellScriptBin}:
writeShellScriptBin "mount-nfs.sh" ''
  if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root." >&2
    exit 1
  fi

  # For each folder, check if a mount point exists, unmount it if it does,
  # and then mount the NFS share.
  for name in ingest photos media; do
    mkdir -p /Volumes/$name
    sleep 0.2
    mount -o resvport,rw,noowners -t nfs 10.0.253.102:/share/$name /Volumes/$name
    sleep 0.2
  done
''

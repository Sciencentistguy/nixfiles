#!/usr/bin/env bash
# mount-nfs.sh: Mount or unmount NFS shares (ingest, photos, media)

set -euo pipefail

if [ "${1:-}" = "--unmount" ]; then
  echo "Unmounting NFS shares..."
  for name in ingest photos media; do
    if mount | grep -q "on /Volumes/$name "; then
      sudo diskutil unmount "/Volumes/$name"
      echo "Unmounted /Volumes/$name"
    else
      echo "/Volumes/$name was not mounted."
    fi
  done
  exit 0
fi

MODE="local"
if [ "${1:-}" = "--remote" ]; then
  MODE="remote"
fi

if [ "$MODE" = "local" ]; then
  NFS_SERVER_IP="10.0.253.102"
else
  NFS_SERVER_IP=$(tailscale ip -1 fileserver)
  if [ -z "$NFS_SERVER_IP" ]; then
    echo "Could not get Tailscale IP for fileserver." >&2
    exit 1
  fi
fi

echo "Using NFS server IP: '$NFS_SERVER_IP'"

for name in ingest photos media; do
  sudo mkdir -p /Volumes/$name
  sleep 0.2
  sudo mount -o resvport,rw,noowners -t nfs $NFS_SERVER_IP:/share/$name /Volumes/$name
  echo "Mounted /Volumes/$name"
  # check if the mount was successful
  if mount | grep -q "on /Volumes/$name "; then
    echo "Successfully mounted /Volumes/$name"
  else
    echo "Failed to mount /Volumes/$name" >&2
  fi
  sleep 0.2
done

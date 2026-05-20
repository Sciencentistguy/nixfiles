{...}: {
  imports = [
    ./awair
    ./backup
    ./borg.nix
    ./docker.nix
    ./gitea.nix
    ./jellyfin.nix
    ./minecraft.nix
    ./nfs.nix
    ./plex.nix
    ./prometheus.nix
    ./samba.nix
    ./syncthing.nix
    ./telegraf.nix
  ];
}

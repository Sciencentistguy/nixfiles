{pkgs, ...}: {
  imports = [
    ./plex.nix
    ./telegraf.nix
    ./docker.nix
  ];
}

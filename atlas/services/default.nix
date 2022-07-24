{pkgs, ...}: {
  imports = [
    ./bonkbot.nix
    ./docker.nix
    ./plex.nix
    ./susbot.nix
    ./telegraf.nix
  ];
}

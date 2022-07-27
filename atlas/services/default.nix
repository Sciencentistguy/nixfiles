{pkgs, ...}: {
  imports = [
    ./bonkbot.nix
    ./borg.nix
    ./docker.nix
    ./plex.nix
    ./susbot.nix
    ./telegraf.nix
  ];
}

{pkgs, ...}: {
  imports = [
    ./bonkbot.nix
    ./borg.nix
    ./docker.nix
    ./gitea.nix
    ./plex.nix
    ./susbot.nix
    ./telegraf.nix
  ];
}

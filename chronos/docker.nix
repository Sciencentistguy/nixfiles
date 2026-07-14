{pkgs, ...}: {
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Optional: maps 'docker' command to podman
  };
}

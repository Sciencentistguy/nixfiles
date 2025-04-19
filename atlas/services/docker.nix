{pkgs, ...}: {
  virtualisation.docker.enable = true;
  virtualisation.docker.extraOptions = "--ipv6 --fixed-cidr-v6 fd00::/80";

  environment.systemPackages = with pkgs; [docker-compose];

}

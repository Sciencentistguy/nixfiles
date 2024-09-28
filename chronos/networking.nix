{
  pkgs,
  systemName,
  ...
}: {
  networking.hostName = systemName; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  services.openssh.enable = true;
  services.tailscale.enable = true;

  services.resolved.enable = true;

  environment.systemPackages = with pkgs; [
    tailscale
  ];

  # Tailscale ran out of fds ??
  systemd.services.tailscaled.serviceConfig.LimitNOFILE = "infinity";

  # networking.firewall.enable = true;
  networking.firewall.enable = false;
  networking.firewall.allowedUDPPorts = [41641];
  networking.firewall.trustedInterfaces = ["tailscale0"];
}

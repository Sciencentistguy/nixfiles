{
  pkgs,
  systemName,
  ...
}: {
  networking.hostName = systemName; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [mullvad-vpn tailscale];

  # Tailscale ran out of fds ??
  systemd.services.tailscaled.serviceConfig.LimitNOFILE = "infinity";

  networking.nameservers = ["1.1.1.1" "8.8.8.8"];
  networking.hosts = {
    "192.168.1.51" = ["atlas"];
  };
}

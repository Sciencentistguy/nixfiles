{
  pkgs,
  systemName,
  ...
}: {
  networking.hostName = systemName; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  networking.hostId = "d2ba5a8d";

  services.openssh.enable = true;
  services.tailscale.enable = true;

  # services.fail2ban = {
    # enable = true;
    # maxretry = 5;
    # ignoreIP = [
      # "100.64.0.0/10" # tailscale IP range
      # "192.168.0.0/16" # LAN IP range
    # ];
  # };

  environment.systemPackages = with pkgs; [tailscale];

  networking.nameservers = ["1.1.1.1" "8.8.8.8"];

  networking.hostFiles = [/secrets/seedbox_host];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };

  networking.firewall.enable = false;
  # networking.firewall.allowedUDPPorts = [41641 9354];
  networking.firewall.checkReversePath = "loose";
  # networking.firewall.trustedInterfaces = ["tailscale0" "docker0" "veth823d546"];
}

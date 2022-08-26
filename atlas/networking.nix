{
  pkgs,
  systemName,
  ...
}: {
  networking.hostName = systemName; # Define your hostname.

  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.tailscale.enable = true;

  environment.systemPackages = with pkgs; [tailscale];

  networking.nameservers = ["1.1.1.1" "8.8.8.8"];

  networking.hostFiles = [/secrets/seedbox_host];

  boot.kernel.sysctl = {
    "net.ipv4.conf.all.forwarding" = true;
    "net.ipv6.conf.all.forwarding" = true;
  };
}

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

  networking.nameservers = ["100.100.100.100" "1.1.1.1" "8.8.8.8"];
  networking.search = ["quigley.xyz.beta.tailscale.net"];
  networking.hosts = {
    "192.168.1.51" = ["atlas"];
  };
}

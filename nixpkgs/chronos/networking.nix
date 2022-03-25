{ pkgs, system, ... }: {
  networking.hostName = system; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  networking.firewall.enable = false;
  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
  environment.systemPackages = with pkgs; [ mullvad-vpn ];
}

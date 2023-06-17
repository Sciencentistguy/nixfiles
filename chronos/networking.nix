{
  pkgs,
  systemName,
  ...
}: {
  networking.hostName = systemName; # Define your hostname.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;
  services.tailscale.enable = true;

  services.resolved.enable = true;

  environment.systemPackages = with pkgs; [mullvad-vpn tailscale];

  # Tailscale ran out of fds ??
  systemd.services.tailscaled.serviceConfig.LimitNOFILE = "infinity";

  networking.nameservers = ["100.100.100.100" "1.1.1.1" "8.8.8.8"];
  networking.search = ["axolotl-shark.ts.net"];

  networking.hosts."192.168.1.3" = ["atlas"];

  networking.firewall.enable = true;
  networking.firewall.allowedUDPPorts = [41641];
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  networking.firewall.extraCommands = ''
    ${pkgs.nftables}/bin/nft -f - <<EOF
    table inet mullvad-ts {
      chain exclude-outgoing {
        type route hook output priority 0; policy accept;
        ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        ip6 daddr fd7a:115c:a1e0::/48 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }
      chain excludeDns {
        type filter hook output priority -10; policy accept;
        ip daddr 100.00.100.100 udp dport 53 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        ip daddr 100.00.100.100 tcp dport 53 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }

      chain allow-incoming {
        type filter hook input priority -100; policy accept;
        iifname "tailscale0" ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
      }
    }
    EOF
  '';
}

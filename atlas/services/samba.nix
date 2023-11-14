{
  pkgs,
  systemName,
  ...
}: {
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # wsdd
  ];

  # samba needs these
  networking.firewall.allowPing = true;
  services.samba.openFirewall = true;

  services.samba = {
    enable = true;
    extraConfig = ''
      workgroup = WORKGROUP
      server string = ${systemName}
      netbios name = ${systemName}
      security = user
      #use sendfile = yes
      #max protocol = smb2
      # allow local network and tailscale
      hosts allow = 192.168.0.0/16 100.64.0.0/10
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      jamie = {
        path = "/storage-pool/nas/jamie";
        browseable = true;
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0755";
        "force user" = "jamie";
        "force group" = "users";
        "fruit:aapl" = "yes";
        "valid users" = "jamie";
      };
      photos = {
        path = "/storage-pool/photos";
        browseable = true;
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0664";
        "directory mask" = "0755";
        "force user" = "jamie";
        "force group" = "users";
        "fruit:aapl" = "yes";
        "valid users" = "jamie";
      };
      # philip = {
      # path = "/storage-pool/nas/philip";
      # browseable = true;
      # "read only" = "no";
      # "guest ok" = "no";
      # "create mask" = "0664";
      # "directory mask" = "0755";
      # };
    };
  };
}

{
  pkgs,
  lib,
  ...
}: {
  systemd.services.prometheus-awair-exporter = let
    prometheus-awair-exporter = pkgs.callPackage ./prometheus-awair-exporter.nix {};
    # sensors ::  [{ name :: String, ip :: String }]
    sensors = [
      {
        name = "jamies-office";
        ip = "192.168.1.150";
      }
      {
        name = "jamies-bedroom";
        ip = "192.168.1.151";
      }
    ];
    sensors' = builtins.map (sensor: ''-s "${sensor.name}":"${sensor.ip}"'') sensors;
  in {
    description = "Prometheus Awair Exporter";
    wantedBy = ["multi-user.target"];
    after = ["network.target"];
    serviceConfig = {
      ExecStart = ''${prometheus-awair-exporter}/bin/prometheus-awair-exporter -a "0.0.0.0:8888" ${lib.concatStringsSep " " sensors'}'';
      User = "prometheus-awair-exporter";
      Group = "prometheus-awair-exporter";
      Restart = "always";
      RestartSec = 5;
    };
  };

  users = {
    users.prometheus-awair-exporter = {
      group = "prometheus-awair-exporter";
      description = "prometheus-awair-exporter user";
      isSystemUser = true;
    };
    groups.prometheus-awair-exporter = {};
  };
}

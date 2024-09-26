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
        name = "jamies-bedroom";
        ip = "10.2.100.1";
      }
      {
        name = "jamies-office";
        ip = "10.2.100.3";
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

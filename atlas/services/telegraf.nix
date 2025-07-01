{pkgs, ...}: {
  services.telegraf = {
    enable = true;
    extraConfig = {
      agent = {
        interval = "1s";
        round_interval = true;

        # XXX: are you sure?
        collection_jitter = "0s";

        flush_interval = "10s";
      };

      outputs = {
        influxdb_v2 = {
          urls = ["http://10.0.253.103:8086"];

          token = "\${INFLUXDB_TOKEN}";

          organization = "quigley.xyz";
          bucket = "telegraf";
        };
      };

      inputs = {
        cpu = {
          percpu = true;
          totalcpu = true;
          collect_cpu_time = true;
          report_active = true;
        };
        disk = {
          ignore_fs = [
            "tmpfs"
            "devtmpfs"
            "devfs"
            "iso9660"
            "overlay"
            "aufs"
            "squashfs"
          ];
        };

        diskio = {};

        ethtool = {
          interface_include = ["enp0s31f6"];
        };

        smart = {
          interval = "5m";
        };

        internal = {};

        interrupts = {};

        kernel = {};

        kernel_vmstat = {};

        linux_sysctl_fs = {};

        mem = {};

        net = {};

        processes = {};

        sensors = {};

        system = {};

        systemd_units = {};

        temp = {};

        zfs = {
          poolMetrics = true;
        };
      };
    };

    environmentFiles = [/secrets/influxdb_token];
  };

  systemd.services.telegraf.path = with pkgs; [
    lm_sensors
    nvme-cli
    smartmontools
  ];
}

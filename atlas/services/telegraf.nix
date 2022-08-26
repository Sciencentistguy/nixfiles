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
          urls = ["http://127.0.0.1:8086"];

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
          ignore_fs = ["tmpfs" "devtmpfs" "devfs" "iso9660" "overlay" "aufs" "squashfs"];
        };

        ethtool = {
          interface_include = ["enp0s31f6"];
        };

        smart = {
          interval = "5m";
        };

        internet_speed = {
          interval = "15m";
          collection_jitter = "5m";
        };

        diskio = {};
        kernel = {};
        mem = {};
        processes = {};
        system = {};
        internal = {};
        interrupts = {};
        kernel_vmstat = {};
        linux_sysctl_fs = {};
        net = {};
        sensors = {};
        systemd_units = {};
        temp = {};
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

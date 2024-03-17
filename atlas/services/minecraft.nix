{
  pkgs,
  flakePkgs,
  config,
  ...
}: {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.early-2024 = {
      enable = true;
      package = flakePkgs.fabric-server;
      jvmOpts = "-Xmx6G -Xms2G";

      symlinks = with pkgs; {
        "mods/lithium.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/nMhjKWVE/lithium-fabric-mc1.20.4-0.12.1.jar";
          sha512 = "70bea154eaafb2e4b5cb755cdb12c55d50f9296ab4c2855399da548f72d6d24c0a9f77e3da2b2ea5f47fa91d1258df4d08c6c6f24a25da887ed71cea93502508";
        };
        "mods/spark.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/l6YH9Als/versions/FeV5OquF/spark-1.10.58-fabric.jar";
          sha512 = "dfc0ba346fea064848ceb3539dd05351327489c6cec09413c4b5ba8a25eefce44da89224cd9e778b7984fa789fbe00a9269e8994e2eec81b79e411f20579fd3c";
        };
        "mods/noisium.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/KuNKN7d2/versions/7p5BqRHp/noisium-1.0.2%2Bmc1.20.x.jar";
          sha512 = "037a0696ba20d053568d9733f9fc0d1dc2b3f980036eaa67eed970b84b5d37f9c1b2ebabdd91de401a27472fcf98383be00fe8e8edb5cb96c5c69d4a3c101ee5";
        };
        "mods/fabric-api.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/cpC3P6YE/fabric-api-0.95.4%2B1.20.4.jar";
          sha512 = "a50ad75003e89289930e9fe65be18b1cabe9aa4bc5179c72f2f23096451f92064d93625f74c0094d9ae8a02f43ad847d2f4fb11fafe88534ebd1a566b0d9d7f1";
        };
        "mods/no-chat-report.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/t4a6hnh0/NoChatReports-FORGE-1.20.4-v2.5.0.jar";
          sha512 = "33b608846c40550e71dfef20fe9d3532d7d4631725d26947d124fcc8a20ef4de8995283db919dba835f139472c3015cfadf9298cc94aa1d2ed0da581b48a1f31";
        };
        "mods/leaves-be-gone.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/AVq17PqV/versions/fSg7kLcG/LeavesBeGone-v20.4.0-1.20.4-Fabric.jar";
          sha512 = "768e3081aa75f33c65fcd61baf65ddac3b82542f7ceba1076056717e1555d0356a2647e28ee984ec6b8f3938ed20f5acfad2a8c0ed1a8199a7beef13e81790d4";
        };
        "mods/forge-config-api-port.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/ohNO6lps/versions/xbVGsTLe/ForgeConfigAPIPort-v20.4.3-1.20.4-Fabric.jar";
          sha512 = "d1eb1bc1aad0bcd3d97deee3d8f3b3eeaa43c332697be043260b7af132c7ee3da6c8b35f635ef7e4a431a95fa6f13dd4a796badeba91bba2b67eff6dc855d8e5";
        };
        "mods/puzzles-lib.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/QAGBst4M/versions/4pPSXzLY/PuzzlesLib-v20.4.21-1.20.4-Fabric.jar";
          sha512 = "26122eafe99e33aa18d0771ad045f4c32358a0e840b5fc3c2187563743bb62f53745e75692867c922c95bbc34958ad0f306b809662f02c1d3462673b024c652e";
        };
      };
    };
  };

  systemd.services."minecraft-prometheus-exporter-early-2024" = {
    description = "minecraft-prometheus-exporter-early-2024";
    wantedBy = ["multi-user.target"];
    after = ["minecraft-server-early-2024.service"];
    environment = {
      MC_RCON_ADDRESS = "127.0.0.1:25575";
      MC_WORLD = "${config.services.minecraft-servers.dataDir}/early-2024/world";
      WEB_DISABLE_EXPORTER_METRICS = "true";
    };
    serviceConfig = {
      ExecStart = "${flakePkgs.minecraft-prometheus-exporter}/bin/minecraft-exporter";
      EnvironmentFile = "/secrets/minecraft-prometheus-exporter-early-2024";
      User = "minecraft";
      Group = "minecraft";
      Type = "simple";
    };
  };
}

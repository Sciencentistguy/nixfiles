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
          sha512 = "037a0696ba20d053568d9733f9fc0d1dc2b3f980036eaa67eed970b84b5d37f9c1b2ebabdd91de401a27472fcf98383be00fe8e8edb5cb96c5c69d4a3c101ee5"; };
        "mods/fabric-api.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/P7dR8mSH/versions/cpC3P6YE/fabric-api-0.95.4%2B1.20.4.jar";
          sha512 = "a50ad75003e89289930e9fe65be18b1cabe9aa4bc5179c72f2f23096451f92064d93625f74c0094d9ae8a02f43ad847d2f4fb11fafe88534ebd1a566b0d9d7f1";
        };
        "mods/no-chat-report.jar" = fetchurl {
          url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/t4a6hnh0/NoChatReports-FORGE-1.20.4-v2.5.0.jar";
          sha512 = "33b608846c40550e71dfef20fe9d3532d7d4631725d26947d124fcc8a20ef4de8995283db919dba835f139472c3015cfadf9298cc94aa1d2ed0da581b48a1f31";
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

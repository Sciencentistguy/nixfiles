{
  pkgs,
  flakePkgs,
  ...
}: {
  systemd.services.bonkbot = {
    enable = true;
    wantedBy = ["multi-user.target"];

    serviceConfig.ExecStart = "${flakePkgs.bonkbot}/bin/bonkbot /secrets/bonkbot_token /secrets/bonkbot_appid";
    serviceConfig.Restart = "on-failure";
  };
}

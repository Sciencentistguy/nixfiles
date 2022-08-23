{
  pkgs,
  flakePkgs,
  ...
}: {
  systemd.services.susbot = {
    enable = true;
    wantedBy = ["multi-user.target"];

    serviceConfig.ExecStart = "${flakePkgs.susbot}/bin/susbot /secrets/susbot_token /secrets/susbot_appid";
    serviceConfig.Restart = "on-failure";
  };
}

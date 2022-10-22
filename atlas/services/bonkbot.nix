{
  pkgs,
  flakePkgs,
  ...
}: {
  services.bonkbot = {
    enable = true;
    tokenPath = "/secrets/bonkbot_token";
    appIdPath = "/secrets/bonkbot_appid";
  };
}

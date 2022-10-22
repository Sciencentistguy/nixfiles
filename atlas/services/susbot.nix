{
  pkgs,
  flakePkgs,
  ...
}: {
  services.susbot = {
    enable = true;
    tokenPath = "/secrets/susbot_token";
    appIdPath = "/secrets/susbot_appid";
  };
}

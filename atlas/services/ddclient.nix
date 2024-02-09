{pkgs, ...}: {
  services.ddclient = {
    enable = true;
    ssl = false; # https seems to be broken
    username = "token";
    passwordFile = "/secrets/cloudflare-token";
    protocol = "cloudflare";
    zone = "quigley.xyz";
    domains = ["*.quigley.xyz"];
  };
}

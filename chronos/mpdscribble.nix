{
  pkgs,
  config,
  ...
}: {
  age.secrets."last.fm_password.age".file = ../secrets/last.fm_password.age;

  services.mpdscribble.verbose = 2;
  services.mpdscribble.enable = true;
  services.mpdscribble.endpoints."last.fm" = {
    username = "Sciencentistguy";
    passwordFile = config.age.secrets."last.fm_password.age".path;
  };
}

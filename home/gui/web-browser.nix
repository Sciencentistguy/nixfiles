{
  pkgs,
  flakePkgs,
  ...
}: {
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox"; # explicitly use old default behaviour
  };
  home.packages = [pkgs.google-chrome flakePkgs.helium];
}

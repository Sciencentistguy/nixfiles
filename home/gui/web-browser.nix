{
  pkgs,
  flakePkgs,
  ...
}: {
  programs.firefox.enable = true;
  home.packages = [pkgs.google-chrome flakePkgs.helium];
}

{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [pkgs.ranger flakePkgs.bulkrename];
}

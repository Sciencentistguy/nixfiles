{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with flakePkgs; [polymc];
}

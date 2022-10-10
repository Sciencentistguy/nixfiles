{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; [polymc];
}

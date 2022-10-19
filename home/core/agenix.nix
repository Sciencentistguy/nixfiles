{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with flakePkgs; [agenix];
}

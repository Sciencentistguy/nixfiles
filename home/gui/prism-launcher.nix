{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with flakePkgs; [prismlauncher];
}

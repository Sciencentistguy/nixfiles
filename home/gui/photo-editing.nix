{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [
    flakePkgs.darktable
    pkgs.gimp3
  ];
}

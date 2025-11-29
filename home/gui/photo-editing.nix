{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [
    flakePkgs.darktable
    pkgs.gimp3
    pkgs.vkdt
  ];
}

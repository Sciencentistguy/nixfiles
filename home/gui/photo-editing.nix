{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [
    flakePkgs.darktable
    pkgs.gimp3
    flakePkgs.vkdt-git
  ];
}

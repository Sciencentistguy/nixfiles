{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = [
    # flakePkgs.darktable
    (pkgs.darktable.override {withAi = true;})
    pkgs.gimp3
    flakePkgs.vkdt-git
  ];
}

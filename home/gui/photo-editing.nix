{pkgs, ...}: {
  home.packages = [
    (pkgs.darktable.override {withAi = true;})
    pkgs.gimp3
  ];
}

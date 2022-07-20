{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; [
    flakePkgs.extract

    bzip2
    gzip
    p7zip
    xz
    zip
  ];
}

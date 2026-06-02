{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; [
    bzip2
    gzip
    _7zz
    unzip
    xz
    zip
  ];
}

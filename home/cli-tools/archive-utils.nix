{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; [
    bzip2
    gzip
    p7zip
    unzip
    xz
    zip
  ];
}

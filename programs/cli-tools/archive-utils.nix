{
  pkgs,
  flakePkgs,
  ...
}: {
  home.packages = with pkgs; [
    flakePkgs.ex

    bzip2
    gzip
    p7zip
    xz
    zip
  ];
}

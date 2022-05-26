{pkgs, ...}: {
  home.packages = with pkgs; [
    bzip2
    gzip
    p7zip
    unzip
    zip
  ];
}

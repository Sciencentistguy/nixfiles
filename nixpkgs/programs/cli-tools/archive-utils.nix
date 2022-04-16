{pkgs, ...}: {
  home.packages = with pkgs; [
    p7zip
    gzip
    zip
    bzip2
  ];
}

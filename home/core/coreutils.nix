{pkgs, ...}: {
  home.packages = with pkgs; [
    coreutils
    gnused
    findutils
    gnugrep
  ];
}

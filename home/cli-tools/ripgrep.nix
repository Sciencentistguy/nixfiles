{pkgs, ...}: {
  home.packages = with pkgs; [
    ripgrep
    # ripgrep-all
  ];
}

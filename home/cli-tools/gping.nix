{pkgs, ...}: {
  home.packages = with pkgs; [gping];
}

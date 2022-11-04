{pkgs, ...}: {
  home.packages = with pkgs; [(lib.lowPrio mkvtoolnix)];
}

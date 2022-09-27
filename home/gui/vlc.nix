{pkgs, ...}: let
  vlc = pkgs.vlc.override {
    libbluray = pkgs.libbluray.override {
      withJava = true;
      withAACS = true;
      withBDplus = true;
    };
  };
in {
  home.packages = [vlc];
}

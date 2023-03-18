{pkgs, ...}: {
  home.packages = with pkgs; [hyfetch];
  home.file.".config/neofetch/config.conf".source = ./hyfetch.conf;
}

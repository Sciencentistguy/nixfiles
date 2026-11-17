{pkgs, lib, ...}: {
  home.packages = with pkgs; lib.optionals (stdenv.isLinux) [wl-clipboard xclip];
}

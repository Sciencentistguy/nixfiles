{
  pkgs,
  systemName,
  lib,
  ...
}: {
  home.packages = with pkgs; lib.optionals (systemName != "atlas") [mpv];
}

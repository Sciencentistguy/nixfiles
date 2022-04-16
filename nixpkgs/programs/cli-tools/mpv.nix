{
  pkgs,
  system,
  lib,
  ...
}: {
  home.packages = with pkgs; lib.optionals (system != "atlas") [mpv];
}

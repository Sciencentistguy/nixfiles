{
  pkgs,
  systemName,
  lib,
  ...
}: {
  home.packages = with pkgs; lib.optional (systemName == "chronos") mpv;
}

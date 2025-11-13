{
  pkgs,
  flakePkgs,
  lib,
  systemName,
  ...
}: {
  home.packages =
    [
      flakePkgs.dr14_tmeter
      flakePkgs.qobuz-identifier
    ]
    ++ lib.optional (systemName == "chronos") pkgs.mpv;
}

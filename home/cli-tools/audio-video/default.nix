{
  pkgs,
  flakePkgs,
  lib,
  systemName,
  ...
}: {
  imports = [./ffmpeg];
  home.packages =
    [
      flakePkgs.dr14_tmeter
      flakePkgs.qobuz-identifier
      pkgs.spek
      pkgs.yt-dlp
    ]
    ++ lib.optionals (systemName == "chronos") [
      pkgs.mpv
      (pkgs.callPackage ./plex-mpv-shim.nix {})
    ];
}

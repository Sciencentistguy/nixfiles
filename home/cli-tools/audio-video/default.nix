{
  pkgs,
  flakePkgs,
  lib,
  systemName,
  ...
}: {
  imports = [./ffmpeg];
  home.packages = let
    mpv = pkgs.mpv.override {scripts = [pkgs.mpvScripts.mpris];};
    plex-mpv-shim = pkgs.plex-mpv-shim.override {inherit mpv;};
  in
    [
      flakePkgs.dr14_tmeter
      flakePkgs.qobuz-identifier
      pkgs.spek
      pkgs.yt-dlp
    ]
    ++ lib.optionals (systemName == "chronos") [
      mpv
      (pkgs.callPackage ./plex-mpv-shim.nix {inherit plex-mpv-shim;})
    ];
}

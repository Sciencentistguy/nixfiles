{
  pkgs,
  flakePkgs,
  lib,
  systemName,
  ...
}: {
  imports = [./ffmpeg];
  home.packages = let
    plex-mpv-shim = pkgs.callPackage ./plex-mpv-shim.nix {};
  in
    [
      flakePkgs.dr14_tmeter
      flakePkgs.qobuz-identifier
      pkgs.spek
      pkgs.yt-dlp
    ]
    ++ lib.optionals (systemName == "chronos") [
      plex-mpv-shim
    ];

  programs.mpv = lib.mkIf (systemName == "chronos") {
    enable = true;
    config = {
      vo = "gpu-next";
      # no-audio-display = true; # see below; https://github.com/nix-community/home-manager/issues/8201
    };
    scripts = with pkgs.mpvScripts; [mpris quality-menu autocrop];

    bindings = {
      F = "script-binding quality_menu/video_formats_toggle";
      "Alt+f" = "script-binding quality_menu/audio_formats_toggle";
    };
  };

  xdg.configFile."mpv/mpv.conf".text =
    lib.mkIf (systemName == "chronos")
    <| lib.mkAfter ''
      no-audio-display
    '';
}

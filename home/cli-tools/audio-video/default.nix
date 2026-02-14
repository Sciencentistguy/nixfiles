{
  pkgs,
  flakePkgs,
  lib,
  systemName,
  ...
}: {
  home.packages = let
    ffmpeg = flakePkgs.videoconverter.ffmpeg;
  in [
    pkgs.dr14_tmeter
    flakePkgs.qobuz-identifier
    pkgs.spek
    pkgs.yt-dlp

    ffmpeg
    flakePkgs.videoconverter
    pkgs.ab-av1
    pkgs.mediainfo

    (pkgs.callPackage ./plot-dovi.nix {inherit ffmpeg;})

    (pkgs.mkvtoolnix.override {
      withGUI = false;
    })
  ];

  # ffmpeg nnedi filter needs weights downloaded separately
  home.file.".ffmpeg/nnedi3_weights".source = flakePkgs.nnedi_weights;

  services.plex-mpv-shim = lib.mkIf (systemName == "chronos") {
    enable = true;
    settings.auto_transcode = false;
  };

  programs.mpv = lib.mkIf (systemName == "chronos") {
    enable = true;
    config = {
      vo = "gpu-next";
      ytdl-raw-options = "cookies-from-browser=firefox";
      # no-audio-display = true; # see below; https://github.com/nix-community/home-manager/issues/8201
    };
    scripts = with pkgs.mpvScripts; [mpris quality-menu autocrop blacklistExtensions];

    # Exclude cover art when playing folders
    scriptOpts.blacklist_extensions.blacklist = lib.strings.concatStringsSep "," ["jpg" "png" "jpeg"];

    bindings = {
      F = "script-binding quality_menu/video_formats_toggle";
      "Alt+f" = "script-binding quality_menu/audio_formats_toggle";
    };
  };

  xdg.configFile."mpv/mpv.conf" = lib.mkIf (systemName == "chronos") {
    text = lib.mkAfter ''
      no-audio-display
    '';
  };
}

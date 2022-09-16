{pkgs, ...}: {
  services.mpd.enable = true;
  services.mpd.dataDir = "/hdd/Music/mpd";
  services.mpd.musicDirectory = "/binds/music-library";
  services.mpd.extraConfig = ''
    audio_output {
      type "pipewire"
      name "pipewire"
    }
    audio_output {
      type   "fifo"
      name   "FIFO"
      path   "/tmp/mpd.fifo"
      format "44100:16:2"
    }
  '';

  services.mpdris2.enable = true;
  services.mpdris2.multimediaKeys = true;

  programs.ncmpcpp.enable = true;
  programs.ncmpcpp.package = pkgs.ncmpcpp.override {
    visualizerSupport = true;
  };
  programs.ncmpcpp.settings = {
    visualizer_fps = 144;
    user_interface = "alternative";
    media_library_primary_tag = "album_artist";
    display_bitrate = "yes";
    mouse_support = "no";
    main_window_color = "green";
    color1 = "white";
    color2 = "yellow";
    now_playing_prefix = "$b$(red)";
    now_playing_suffix = "$(end)$/b";
    progressbar_color = "black:b";
    progressbar_elapsed_color = "red:b";
  };
}

{ pkgs, ... }: {
  services.mpd.enable = true;
  services.mpd.dataDir = "/hdd/Music/mpd";
  services.mpd.musicDirectory = "/binds/music-library";
  services.mpd.extraConfig = ''
      audio_output {
      type "pipewire"
      name "My PipeWire Output"
    }
  '';

  services.mpdris2.enable = true;
  services.mpdris2.multimediaKeys = true;

  programs.ncmpcpp.enable = true;
  programs.ncmpcpp.settings = {
    visualizer_fps = 144;
    user_interface = "alternative";
    media_library_primary_tag = "album_artist";
    display_bitrate = "yes";
    mouse_support = "no";
    main_window_color = "green";
    color1 = "white";
    color2 = "yellow";
    progressbar_color = "black:b";
    progressbar_elapsed_color = "red:b";
  };
}

{
  pkgs,
  config,
  ...
}: let
  mpdSocket = "/run/user/${toString config.home.uid}/mpd/socket";
in {
  services.mpd.enable = true;
  services.mpd.network.listenAddress = mpdSocket;
  services.mpd.musicDirectory = "/media/Music";
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

    replaygain "off"
  '';

  systemd.user.services.mpd.Service.ReadOnlyPaths = config.services.mpd.musicDirectory;
  systemd.user.services.mpd.Service.TimeoutStopSec = 10;
  systemd.user.services.mpd.Service.RuntimeDirectory = "mpd";
  # The HDD can take a while to respond right after boot
  systemd.user.services.mpd.Service.TimeoutStartSec = 300;
  systemd.user.services.mpd.Service.Restart = "on-failure";
  systemd.user.services.mpd.Service.RestartSec = 5;

  home.sessionVariables.MPD_HOST = mpdSocket;

  services.mpdris2.enable = true;
  services.mpdris2.mpd.host = mpdSocket;
  services.mpdris2.settings.Bling.mmkeys = true;

  services.mpdscribble = {
    enable = true;
    host = mpdSocket;
    endpoints."last.fm" = {
      username = "Sciencentistguy";
      passwordFile = "/secrets/lastfm-password";
    };
    verbose = 2;
  };

  programs.ncmpcpp.enable = true;
  programs.ncmpcpp.package = pkgs.ncmpcpp.override {
    visualizerSupport = true;
  };
  programs.ncmpcpp.settings = {
    mpd_host = mpdSocket;
    visualizer_fps = 165;
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

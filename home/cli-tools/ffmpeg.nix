{
  pkgs,
  flakePkgs,
  systemName,
  ...
}: let
  ffmpeg = flakePkgs.videoconverter.ffmpeg.override {
    nvenc = systemName == "chronos";
  };
in {
  home.packages = [
    ffmpeg
    flakePkgs.videoconverter

    (pkgs.mkvtoolnix.override {
      withGUI = false;
    })
  ];

  # ffmpeg nnedi filter needs weights downloaded separately
  home.file.".ffmpeg/nnedi3_weights".source = flakePkgs.nnedi_weights;
}

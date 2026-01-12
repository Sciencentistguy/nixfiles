{
  pkgs,
  flakePkgs,
  ...
}: let
  ffmpeg = flakePkgs.videoconverter.ffmpeg;
in {
  home.packages = [
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
}

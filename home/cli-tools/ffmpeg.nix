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
  ];

  # ffmpeg nnedi filter needs weights downloaded separately
  home.file.".ffmpeg/nnedi3_weights".source = builtins.fetchurl {
    url = "https://github.com/dubhater/vapoursynth-nnedi3/raw/cc6f6065e09c9241553cb51f10002a7314d66bfa/src/nnedi3_weights.bin";
    sha256 = "0hhx4n19qaj3g68f5kqjk23cj063g4y2zidivq9pdfrm0i1q5wr7";
  };
}

{
  pkgs,
  systemName,
  ...
}: let
  ffmpeg = pkgs.ffmpeg-full.override {
    nonfreeLicensing = true;
    fdkaacExtlib = true;
    nvenc = systemName == "chronos";
  };
in {
  home.packages = [
    ffmpeg
    pkgs.videoconverter
  ];
}

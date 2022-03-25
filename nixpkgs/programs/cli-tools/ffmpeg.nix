{ pkgs, system, ... }:
let ffmpeg = pkgs.ffmpeg-full.override {
  nonfreeLicensing = true;
  fdkaacExtlib = true;
  nvenc = system == "chronos";
};
in
{
  home.packages = [ ffmpeg ];
}

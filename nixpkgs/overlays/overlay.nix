self: super: {
  ffmpeg-full = super.ffmpeg-full.override {
    nonfreeLicensing = true;
    fdkaacExtlib = true;
  };
}
